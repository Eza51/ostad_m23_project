<template>
  <div class="profile-container">
    <h2>My Profile</h2>

    <div class="profile-pic">
      <img :src="profileImage || defaultImage" alt="Profile" />
    </div>

    <input type="file" @change="onFileChange" />
    <button @click="uploadProfile">Upload</button>

    <p class="success" v-if="success">{{ success }}</p>
    <p class="error" v-if="error">{{ error }}</p>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import axios from 'axios'

const defaultImage = '/default-profile.png'
const profileImage = ref('')
const file = ref(null)
const success = ref('')
const error = ref('')

const headers = { Authorization: `Bearer ${localStorage.getItem('token')}` }

onMounted(async () => {
  try {
    const res = await axios.get('http://127.0.0.1:8000/api/profile', { headers })
    profileImage.value = res.data.profile_image
  } catch {
    profileImage.value = ''
  }
})

const onFileChange = (e) => {
  file.value = e.target.files[0]
}

const uploadProfile = async () => {
  if (!file.value) return
  const formData = new FormData()
  formData.append('profile_image', file.value)

  try {
    const res = await axios.post('http://127.0.0.1:8000/api/profile/upload', formData, {
      headers: { ...headers, 'Content-Type': 'multipart/form-data' }
    })
    profileImage.value = res.data.profile_image
    success.value = 'Profile updated successfully'
    error.value = ''
  } catch (e) {
    error.value = 'Upload failed'
    success.value = ''
  }
}
</script>

<style>
.profile-container {
  max-width: 400px;
  margin: 50px auto;
  padding: 20px;
  border: 1px solid #aaa;
  border-radius: 8px;
}
.profile-pic img {
  width: 150px;
  height: 150px;
  border-radius: 50%;
  display: block;
  margin-bottom: 10px;
}
input[type="file"] {
  display: block;
  margin-bottom: 10px;
}
button {
  padding: 8px 12px;
  cursor: pointer;
}
.success { color: green; margin-top: 10px; }
.error { color: red; margin-top: 10px; }
</style>
