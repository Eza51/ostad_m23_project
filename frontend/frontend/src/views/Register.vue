<template>
  <div class="page">
    <div class="form-container">
      <h2>Create Account</h2>
      <p class="subtitle">Register to continue</p>

      <input v-model="name" placeholder="Full Name" />
      <input v-model="username" placeholder="Username" />
      <input v-model="email" type="email" placeholder="Email Address" />
      <input v-model="password" type="password" placeholder="Password" />
      <input
        v-model="password_confirmation"
        type="password"
        placeholder="Confirm Password"
      />

      <button @click="register">Register</button>

      <p class="error" v-if="error">{{ error }}</p>

      <p class="login-link">
        Already have an account?
        <router-link to="/login">Login</router-link>
      </p>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import axios from 'axios'
import { useRouter } from 'vue-router'

const name = ref('')
const username = ref('')
const email = ref('')
const password = ref('')
const password_confirmation = ref('')
const error = ref('')
const router = useRouter()

const register = async () => {
  error.value = ''
  try {
    await axios.post('http://127.0.0.1:8000/api/register', {
      name: name.value,
      username: username.value,
      email: email.value,
      password: password.value,
      password_confirmation: password_confirmation.value
    })
    router.push('/login')
  } catch (e) {
    error.value = 'Registration failed'
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

.form-container {
  width: 100%;
  max-width: 380px;
  background: #ffffff;
  padding: 30px;
  border-radius: 10px;
  box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
}

.form-container h2 {
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

.form-container input {
  width: 100%;
  padding: 12px;
  margin-bottom: 12px;
  border: 1px solid #ddd;
  border-radius: 6px;
  font-size: 14px;
}

.form-container input:focus {
  outline: none;
  border-color: #4f46e5;
}

.form-container button {
  width: 100%;
  padding: 12px;
  background: #4f46e5;
  color: white;
  border: none;
  border-radius: 6px;
  font-size: 15px;
  cursor: pointer;
  margin-top: 5px;
}

.form-container button:hover {
  background: #4338ca;
}

.error {
  margin-top: 10px;
  color: #dc2626;
  font-size: 14px;
  text-align: center;
}

.login-link {
  margin-top: 15px;
  text-align: center;
  font-size: 14px;
}

.login-link a {
  color: #4f46e5;
  text-decoration: none;
  font-weight: 500;
}
</style>
