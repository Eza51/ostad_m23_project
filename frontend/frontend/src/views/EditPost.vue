<template>
  <div>
    <h2>Edit Post</h2>
    <input v-model="title" placeholder="Title" />
    <textarea v-model="content" placeholder="Content"></textarea>
    <select v-model="visibility">
      <option value="public">Public</option>
      <option value="private">Private</option>
    </select>
    <button @click="updatePost">Update</button>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import axios from 'axios'
import { useRouter, useRoute } from 'vue-router'

const route = useRoute()
const router = useRouter()
const postId = route.params.id

const title = ref('')
const content = ref('')
const visibility = ref('public')

onMounted(async () => {
  const res = await axios.get(`/posts/${postId}`)
  title.value = res.data.title
  content.value = res.data.content
  visibility.value = res.data.visibility
})

const updatePost = async () => {
  try {
    await axios.put(`/posts/${postId}`, { title: title.value, content: content.value, visibility: visibility.value })
    router.push('/')
  } catch (e) {
    console.log('Error updating post', e)
  }
}
</script>
