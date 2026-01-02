<template>
  <div class="comments">
    <h4>Comments</h4>

    <!-- ADD COMMENT -->
    <div v-if="isLoggedIn">
      <input v-model="newComment[post.id]" placeholder="Write a comment" />
      <button @click="addComment(post.id)">Comment</button>
    </div>

    <!-- COMMENT LIST -->
    <div v-for="comment in post.comments || []" :key="comment.id" class="comment">
      <p><strong>{{ comment.user.name }}</strong>: {{ comment.comment }}</p>

      <!-- REPLY -->
      <div v-if="isLoggedIn" class="reply-box">
        <input v-model="replyText[comment.id]" placeholder="Reply..." />
        <button @click="addReply(post.id, comment.id)">Reply</button>
      </div>

      <!-- REPLIES -->
      <div class="replies">
        <div v-for="reply in comment.replies || []" :key="reply.id">
          ↳ <strong>{{ reply.user.name }}</strong>: {{ reply.comment }}
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
   
import { reactive } from 'vue'
import axios from 'axios'

const props = defineProps({
  post: Object,
  isLoggedIn: Boolean
})

const newComment = reactive({})
const replyText = reactive({})

const headers = props.isLoggedIn
  ? { Authorization: `Bearer ${localStorage.getItem('token')}` }
  : {}

async function addComment(postId) {
  if (!newComment[postId]) return
  const res = await axios.post('http://127.0.0.1:8000/api/comments', {
    post_id: postId,
    comment: newComment[postId]
  }, { headers })
  props.post.comments.push(res.data)
  newComment[postId] = ''
}

async function addReply(postId, parentId) {
  if (!replyText[parentId]) return
  const res = await axios.post('http://127.0.0.1:8000/api/comments', {
    post_id: postId,
    parent_id: parentId,
    comment: replyText[parentId]
  }, { headers })
  const parent = props.post.comments.find(c => c.id === parentId)
  parent.replies = parent.replies || []
  parent.replies.push(res.data)
  replyText[parentId] = ''
}
</script>
