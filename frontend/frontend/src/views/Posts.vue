<template>
  <div class="container">
    <h2>Posts</h2>

    <div v-for="post in paginatedPosts" :key="post.id" class="post-card">
      <h3>{{ post.title }}</h3>
      <p>{{ post.content }}</p>
      <img v-if="post.image" :src="'http://127.0.0.1:8000/uploads/posts/' + post.image" class="post-image" />

      <p class="meta">
        <strong>Author:</strong> {{ post.user.name }} |
        <strong>Visibility:</strong> {{ post.visibility }}
      </p>

      <!-- ACTIONS: Like / Bookmark -->
      <div class="post-actions">
        <button @click="toggleLike(post)" :disabled="!isLoggedIn">
          <span v-if="post.is_liked">💙</span><span v-else>🤍</span>
          {{ post.likes_count ?? 0 }}
        </button>

        <button @click="toggleBookmark(post)" :disabled="!isLoggedIn">
          <span v-if="post.is_bookmarked">🔖 Saved</span><span v-else>🔖 Save</span>
        </button>

        <!-- Edit / Delete -->
        <div v-if="isLoggedIn && post.user_id === currentUserId" class="actions owner">
          <button @click="editPost(post)">Edit</button>
          <button @click="deletePost(post.id)">Delete</button>
        </div>
      </div>

      <!-- Comments toggle -->
      <div class="comments-toggle">
        <button @click="toggleComments(post)">
          {{ showComments[post.id] ? 'Hide' : 'Show' }} Comments
          <span v-if="(post.comments_count ?? comments[post.id]?.length) > 0">
            ({{ post.comments_count ?? comments[post.id]?.length }})
          </span>
        </button>
      </div>

      <!-- Comments section -->
      <div v-if="showComments[post.id]" class="comments-section">
        <!-- Add top-level comment -->
        <div class="add-comment" v-if="isLoggedIn">
          <textarea
            v-model="newComment[post.id]"
            :placeholder="'Write a comment for ' + post.title"
            rows="2"
          ></textarea>
          <button @click="postComment(post.id)" :disabled="!newComment[post.id]">Comment</button>
        </div>

        <!-- Comments list -->
        <div class="comment" v-for="c in comments[post.id]" :key="c.id">
          <div class="comment-body">
            <strong>{{ c.user.name }}</strong> <span class="comment-text">{{ c.comment }}</span>
            <div class="comment-meta">
              <small>— {{ relativeTime(c.created_at) }}</small>
              <button v-if="isLoggedIn" @click="prepareReply(post.id, c.id)">Reply</button>
            </div>
          </div>

          <!-- Reply input (shown when replying to this comment) -->
          <div v-if="replyTo[post.id] === c.id" class="reply-box">
            <textarea v-model="replyText[post.id]" rows="2" placeholder="Write a reply"></textarea>
            <button @click="postComment(post.id, c.id)" :disabled="!replyText[post.id]">Reply</button>
            <button @click="cancelReply(post.id)">Cancel</button>
          </div>

          <!-- Replies (nested) -->
          <div class="replies" v-if="c.replies && c.replies.length">
            <div class="reply" v-for="r in c.replies" :key="r.id">
              <strong>{{ r.user.name }}</strong> <span class="comment-text">{{ r.comment }}</span>
              <div class="comment-meta">
                <small>— {{ relativeTime(r.created_at) }}</small>
              </div>
            </div>
          </div>
        </div>

        <!-- Loading / no comments -->
        <div v-if="loadingComments[post.id]" class="loading">Loading comments...</div>
        <div v-else-if="!comments[post.id] || comments[post.id].length === 0" class="no-comments">
          No comments yet.
        </div>
      </div>
    </div>

    <!-- Pagination -->
    <div class="pagination" v-if="totalPages > 1">
      <button @click="prevPage" :disabled="currentPage === 1">Prev</button>
      <span>Page {{ currentPage }} of {{ totalPages }}</span>
      <button @click="nextPage" :disabled="currentPage === totalPages">Next</button>
    </div>

    <!-- CREATE / EDIT POST -->
    <div v-if="isLoggedIn" class="create-post">
      <h3>{{ editingPost ? 'Edit Post' : 'Create Post' }}</h3>

      <input v-model="title" placeholder="Title" />
      <textarea v-model="content" placeholder="Content"></textarea>

      <input type="file" @change="onFileChange" />

      <select v-model="visibility">
        <option value="public">Public</option>
        <option value="private">Private</option>
      </select>

      <button v-if="!editingPost" @click="createPost">Create</button>
      <button v-if="editingPost" @click="updatePost">Update</button>
      <button v-if="editingPost" @click="cancelEdit">Cancel</button>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, reactive } from 'vue'
import axios from 'axios'

// state
const posts = ref([])
const isLoggedIn = ref(!!localStorage.getItem('token'))
const currentUserId = ref(Number(localStorage.getItem('user_id')) || null)

const title = ref('')
const content = ref('')
const visibility = ref('public')
const image = ref(null)
const editingPost = ref(null)

// comments & replies
const comments = reactive({}) // comments[postId] = [ ...topLevelComments with replies ]
const showComments = reactive({}) // showComments[postId] = bool
const loadingComments = reactive({}) // loadingComments[postId] = bool
const newComment = reactive({}) // newComment[postId] = string for top-level comments
const replyTo = reactive({}) // replyTo[postId] = commentId being replied to
const replyText = reactive({}) // replyText[postId] = string used for reply input

// Pagination
const currentPage = ref(1)
const perPage = 5
const totalPages = computed(() => Math.ceil(posts.value.length / perPage))
const paginatedPosts = computed(() => {
  const start = (currentPage.value - 1) * perPage
  return posts.value.slice(start, start + perPage)
})

// Helper: dynamic auth headers (read token at request time)
function authHeaders() {
  const token = localStorage.getItem('token')
  return token ? { Authorization: `Bearer ${token}` } : {}
}

// FETCH POSTS
onMounted(fetchPosts)
async function fetchPosts() {
  try {
    const token = localStorage.getItem('token')
    const url = token ? 'http://127.0.0.1:8000/api/posts' : 'http://127.0.0.1:8000/api/posts/public'
    const res = await axios.get(url, { headers: authHeaders() })
    // Ensure some helpful defaults for likes/bookmarks/comments_count
    posts.value = res.data.map(p => ({
      ...p,
      likes_count: p.likes_count ?? 0,
      is_liked: !!p.is_liked, // backend may set this; default false
      is_bookmarked: !!p.is_bookmarked,
      comments_count: p.comments_count ?? null // optional
    }))
  } catch (err) {
    console.error('fetchPosts error', err)
  }
}

// FILE change
const onFileChange = e => { image.value = e.target.files[0] }

// CREATE
async function createPost() {
  if (!title.value || !content.value) return
  try {
    const fd = new FormData()
    fd.append('title', title.value)
    fd.append('content', content.value)
    fd.append('visibility', visibility.value)
    if (image.value) fd.append('image', image.value)

    const res = await axios.post('http://127.0.0.1:8000/api/posts', fd, { headers: authHeaders() })
    // Prepend new post (ensure same shape)
    const p = {
      ...res.data,
      likes_count: res.data.likes_count ?? 0,
      is_liked: !!res.data.is_liked,
      is_bookmarked: !!res.data.is_bookmarked
    }
    posts.value.unshift(p)
    resetForm()
  } catch (err) {
    console.error('createPost error', err)
  }
}

// EDIT
function editPost(post) {
  editingPost.value = post
  title.value = post.title
  content.value = post.content
  visibility.value = post.visibility
}

// UPDATE
async function updatePost() {
  try {
    const fd = new FormData()
    fd.append('title', title.value)
    fd.append('content', content.value)
    fd.append('visibility', visibility.value)
    if (image.value) fd.append('image', image.value)

    await axios.post(
      `http://127.0.0.1:8000/api/posts/${editingPost.value.id}?_method=PUT`,
      fd,
      { headers: authHeaders() }
    )
    await fetchPosts()
    resetForm()
  } catch (err) {
    console.error('updatePost error', err)
  }
}

// DELETE
async function deletePost(id) {
  try {
    await axios.delete(`http://127.0.0.1:8000/api/posts/${id}`, { headers: authHeaders() })
    posts.value = posts.value.filter(p => p.id !== id)
    // also clear comments & visibility state
    delete comments[id]
    delete showComments[id]
  } catch (err) {
    console.error('deletePost error', err)
  }
}

// PAGINATION
const prevPage = () => { if(currentPage.value>1) currentPage.value-- }
const nextPage = () => { if(currentPage.value<totalPages.value) currentPage.value++ }

function resetForm() {
  editingPost.value = null
  title.value = ''
  content.value = ''
  visibility.value = 'public'
  image.value = null
}

// -----------------------------
// LIKE / BOOKMARK
// -----------------------------
async function toggleLike(post) {
  if (!isLoggedIn.value) { alert('Please log in to like posts'); return }
  try {
    // Optimistic UI update
    post.is_liked = !post.is_liked
    post.likes_count = (post.likes_count ?? 0) + (post.is_liked ? 1 : -1)

    const res = await axios.post(`http://127.0.0.1:8000/api/like/${post.id}`, {}, { headers: authHeaders() })
    // optionally sync with backend data if returned
    // if backend returns undone/redo message we could adjust but assume toggle works
  } catch (err) {
    // rollback on error
    post.is_liked = !post.is_liked
    post.likes_count = (post.likes_count ?? 0) + (post.is_liked ? 1 : -1)
    console.error('toggleLike error', err)
  }
}

async function toggleBookmark(post) {
  if (!isLoggedIn.value) { alert('Please log in to bookmark posts'); return }
  try {
    // optimistic
    post.is_bookmarked = !post.is_bookmarked
    const res = await axios.post(`http://127.0.0.1:8000/api/bookmark/${post.id}`, {}, { headers: authHeaders() })
  } catch (err) {
    post.is_bookmarked = !post.is_bookmarked
    console.error('toggleBookmark error', err)
  }
}

// -----------------------------
// COMMENTS (list + nested replies + add)
// -----------------------------
// toggle comment visibility; fetch comments if not loaded
async function toggleComments(post) {
  showComments[post.id] = !showComments[post.id]
  // initialize containers if needed
  if (!comments[post.id]) comments[post.id] = []
  if (!newComment[post.id]) newComment[post.id] = ''
  if (showComments[post.id] && comments[post.id].length === 0) {
    await fetchComments(post.id)
  }
}

// fetch comments for postId (returns top-level with replies loaded)
async function fetchComments(postId) {
  try {
    loadingComments[postId] = true
    const res = await axios.get(`http://127.0.0.1:8000/api/comments/${postId}`, { headers: authHeaders() })
    // Assuming backend returns top-level comments with replies as array `replies`
    comments[postId] = res.data.map(c => ({
      ...c,
      replies: c.replies ?? []
    }))
  } catch (err) {
    console.error('fetchComments error', err)
    comments[postId] = []
  } finally {
    loadingComments[postId] = false
  }
}

// prepare reply UI for comment
function prepareReply(postId, commentId) {
  replyTo[postId] = commentId
  replyText[postId] = ''
}

// cancel reply
function cancelReply(postId) {
  replyTo[postId] = null
  replyText[postId] = ''
}

// post a comment or reply. parentId optional for reply.
async function postComment(postId, parentId = null) {
  if (!isLoggedIn.value) { alert('Please log in to comment'); return }
  try {
    const payload = {
      post_id: postId,
      comment: parentId ? replyText[postId] : newComment[postId],
      parent_id: parentId
    }
    if (!payload.comment || !payload.comment.trim()) return

    const res = await axios.post('http://127.0.0.1:8000/api/comments', payload, { headers: authHeaders() })
    const created = res.data.comment ?? res.data // accommodate different response shapes

    // update local comments structure:
    if (!comments[postId]) comments[postId] = []

    if (parentId) {
      // find parent in top-level comments and add as reply
      const parent = comments[postId].find(c => c.id === parentId)
      if (parent) {
        parent.replies = parent.replies || []
        parent.replies.push(created)
      } else {
        // If parent not in current list (edge case) — re-fetch
        await fetchComments(postId)
      }
      // clear reply UI
      replyTo[postId] = null
      replyText[postId] = ''
    } else {
      // push as top-level comment
      comments[postId].unshift({ ...created, replies: created.replies ?? [], user: created.user ?? { name: 'You' } })
      newComment[postId] = ''
    }

    // update post comments_count if present
    const post = posts.value.find(p => p.id === postId)
    if (post) {
      post.comments_count = (post.comments_count ?? 0) + 1
    }
  } catch (err) {
    console.error('postComment error', err)
  }
}

// Simple time formatter (you can enhance or replace with dayjs)
function relativeTime(iso) {
  if (!iso) return ''
  const d = new Date(iso)
  const diff = (Date.now() - d.getTime()) / 1000 // seconds
  if (diff < 60) return `${Math.floor(diff)}s ago`
  if (diff < 3600) return `${Math.floor(diff / 60)}m ago`
  if (diff < 86400) return `${Math.floor(diff / 3600)}h ago`
  return d.toLocaleString()
}
</script>

<style>
/* Layout */
.container {
  max-width: 900px;
  margin: 40px auto;
  padding: 0 15px;
  font-family: system-ui, -apple-system, BlinkMacSystemFont, sans-serif;
  background: #f5f7fb;
}

/* Post card */
.post-card {
  background: #ffffff;
  border-radius: 14px;
  padding: 20px;
  margin-bottom: 22px;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.06);
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.post-card:hover {
  transform: translateY(-3px);
  box-shadow: 0 14px 32px rgba(0, 0, 0, 0.1);
}

.post-card h3 {
  margin-bottom: 6px;
  color: #1f2937;
}

.post-card p {
  color: #374151;
  line-height: 1.6;
}

/* Image */
.post-image {
  max-width: 100%;
  margin-top: 12px;
  border-radius: 10px;
}

/* Meta info */
.meta {
  font-size: 13px;
  color: #6b7280;
  margin-top: 10px;
}

/* Actions */
.post-actions {
  display: flex;
  gap: 12px;
  align-items: center;
  margin-top: 14px;
  flex-wrap: wrap;
}

.post-actions button {
  background: #f3f4f6;
  border: none;
  padding: 6px 12px;
  border-radius: 20px;
  font-size: 14px;
  cursor: pointer;
  transition: background 0.2s ease;
}

.post-actions button:hover:not(:disabled) {
  background: #e5e7eb;
}

.post-actions button:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

/* Owner actions */
.actions.owner button {
  background: #eef2ff;
  color: #4338ca;
}

.actions.owner button:hover {
  background: #e0e7ff;
}

/* Comments toggle */
.comments-toggle {
  margin-top: 12px;
}

.comments-toggle button {
  background: none;
  border: none;
  color: #2563eb;
  cursor: pointer;
  font-size: 14px;
}

/* Comments section */
.comments-section {
  margin-top: 14px;
  padding-top: 12px;
  border-top: 1px dashed #e5e7eb;
}

/* Add comment */
.add-comment textarea,
.reply-box textarea {
  width: 100%;
  padding: 10px;
  border-radius: 8px;
  border: 1px solid #d1d5db;
  font-size: 14px;
  resize: vertical;
}

.add-comment button,
.reply-box button {
  margin-top: 6px;
  padding: 6px 12px;
  border-radius: 6px;
  border: none;
  background: #4f46e5;
  color: #fff;
  cursor: pointer;
  font-size: 13px;
}

.reply-box button:last-child {
  background: #9ca3af;
}

.add-comment button:hover,
.reply-box button:hover {
  opacity: 0.9;
}

/* Comment */
.comment {
  padding: 10px 0;
  border-bottom: 1px solid #f1f1f1;
}

.comment-body strong {
  color: #111827;
}

.comment-text {
  margin-left: 6px;
  color: #374151;
}

.comment-meta {
  font-size: 12px;
  color: #6b7280;
  margin-top: 4px;
}

.comment-meta button {
  background: none;
  border: none;
  color: #2563eb;
  cursor: pointer;
  font-size: 12px;
  margin-left: 8px;
}

/* Replies */
.replies {
  margin-left: 22px;
  margin-top: 8px;
}

.reply {
  padding: 6px 10px;
  background: #f9fafb;
  border-radius: 6px;
  margin-bottom: 6px;
  border-left: 3px solid #e5e7eb;
}

/* States */
.loading {
  font-size: 13px;
  color: #6b7280;
  font-style: italic;
}

.no-comments {
  font-size: 13px;
  color: #9ca3af;
  font-style: italic;
}

/* Pagination */
.pagination {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 14px;
  margin: 30px 0;
}

.pagination button {
  padding: 6px 14px;
  border-radius: 6px;
  border: 1px solid #d1d5db;
  background: #ffffff;
  cursor: pointer;
}

.pagination button:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

/* Create post */
.create-post {
  margin-top: 40px;
  padding: 20px;
  border-radius: 14px;
  background: #ffffff;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.06);
}

.create-post h3 {
  margin-bottom: 10px;
}

.create-post input,
.create-post textarea,
.create-post select {
  width: 100%;
  padding: 10px;
  margin-bottom: 10px;
  border-radius: 8px;
  border: 1px solid #d1d5db;
  font-size: 14px;
}

.create-post button {
  padding: 8px 14px;
  border-radius: 6px;
  border: none;
  background: #4f46e5;
  color: #fff;
  cursor: pointer;
}

</style>
