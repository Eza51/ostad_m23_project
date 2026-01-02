<template>
  <div class="page">
    <div class="auth-container">
      <h2>Welcome Back</h2>
      <p class="subtitle">Login to your account</p>

      <input v-model="email" placeholder="Email address" />
      <input v-model="password" type="password" placeholder="Password" />

      <button @click="login">Login</button>

      <p class="error" v-if="error">{{ error }}</p>

      <router-link class="forgot" to="/forget-password">
        Forgot Password?
      </router-link>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import axios from 'axios'
import { useRouter } from 'vue-router'
import { isLoggedIn, currentUserId } from '../store/auth'

const email = ref('')
const password = ref('')
const error = ref('')
const router = useRouter()

const login = async () => {
  try {
    const res = await axios.post('http://127.0.0.1:8000/api/login', {
      email: email.value,
      password: password.value
    })
    localStorage.setItem('token', res.data.token)
    localStorage.setItem('user_id', res.data.user.id)

    currentUserId.value = res.data.user.id
    isLoggedIn.value = true

    router.push('/')
  } catch {
    error.value = 'Invalid credentials'
  }
}
</script>

<style scoped>
.page {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #eef2f3, #d9e4ec);
}

.auth-container {
  width: 100%;
  max-width: 380px;
  background: #fff;
  padding: 30px;
  border-radius: 10px;
  box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
}

.auth-container h2 {
  text-align: center;
  margin-bottom: 5px;
  color: #333;
}

.subtitle {
  text-align: center;
  font-size: 14px;
  color: #777;
  margin-bottom: 20px;
}

.auth-container input {
  width: 100%;
  padding: 12px;
  margin-bottom: 12px;
  border: 1px solid #ddd;
  border-radius: 6px;
  font-size: 14px;
}

.auth-container input:focus {
  outline: none;
  border-color: #4f46e5;
}

.auth-container button {
  width: 100%;
  padding: 12px;
  background: #4f46e5;
  color: white;
  border: none;
  border-radius: 6px;
  font-size: 15px;
  cursor: pointer;
}

.auth-container button:hover {
  background: #4338ca;
}

.error {
  margin-top: 10px;
  color: #dc2626;
  font-size: 14px;
  text-align: center;
}

.forgot {
  display: block;
  margin-top: 15px;
  text-align: center;
  font-size: 14px;
  color: #4f46e5;
  text-decoration: none;
}
</style>
