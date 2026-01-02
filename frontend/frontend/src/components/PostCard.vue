<template>
  <div class="post-card">
    <h3>{{ post.title }}</h3>
    <p>{{ post.content }}</p>
    <img v-if="post.image" :src="'http://127.0.0.1:8000/uploads/posts/' + post.image" class="post-image" />

    <p class="meta">
      <strong>Author:</strong> {{ post.user.name }} |
      <strong>Visibility:</strong> {{ post.visibility }}
    </p>

    <!-- EDIT / DELETE -->
    <div v-if="currentUserId === post.user_id" class="actions owner">
      <button @click="$emit('edit-post', post)">Edit</button>
      <button @click="$emit('delete-post', post.id)">Delete</button>
    </div>
  </div>
</template>

<script setup>
const props = defineProps({
  post: Object,
  currentUserId: [String, Number]
})
</script>

<style>
.post-card { border:1px solid #ddd; padding:15px; margin-bottom:20px; border-radius:10px; background:#fff; }
.post-image { max-width:100%; margin-top:10px; border-radius:5px; }
.meta { font-size:13px; color:#555; }
.actions button { margin-right:5px; }
</style>
