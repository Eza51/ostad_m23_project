<template>
  <nav>
    <router-link to="/">Posts</router-link>
    <router-link v-if="!isLoggedIn" to="/login">Login</router-link>
    <router-link v-if="!isLoggedIn" to="/register">Register</router-link>
    <button v-if="isLoggedIn" @click="logout">Logout</button>
  </nav>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()
const isLoggedIn = ref(!!localStorage.getItem('token'))

const logout = () => {
  localStorage.removeItem('token')
  isLoggedIn.value = false
  router.push('/login')
}
</script>
