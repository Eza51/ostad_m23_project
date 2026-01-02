<template>
  <div>
    <h2>Create Post</h2>
    <input v-model="title" placeholder="Title" />
    <textarea v-model="content" placeholder="Content"></textarea>
    <select v-model="visibility">
      <option value="public">Public</option>
      <option value="private">Private</option>
    </select>
    <button @click="createPost">Create</button>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import axios from 'axios'
import { useRouter } from 'vue-router'

const title = ref('')
const content = ref('')
const visibility = ref('public')
const router = useRouter()

const createPost = async () => {
  try {
    await axios.post('/posts', { title: title.value, content: content.value, visibility: visibility.value })
    router.push('/')
  } catch (e) {
    console.log('Error creating post', e)
  }
}
</script>
