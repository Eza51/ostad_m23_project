<template>
  <div class="page">
    <div class="form-container">
      <h2>Forgot Password</h2>
      <p class="subtitle">
        Enter your email and we’ll send you a reset token
      </p>

      <input
        v-model="email"
        type="email"
        placeholder="Enter your email address"
      />

      <button @click="sendResetLink">
        Send Reset Token
      </button>

      <p class="success" v-if="success">{{ success }}</p>
      <p class="error" v-if="error">{{ error }}</p>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import axios from 'axios'

const email = ref('')
const success = ref('')
const error = ref('')

const sendResetLink = async () => {
  success.value = ''
  error.value = ''

  try {
    const res = await axios.post('/forgot-password', {
      email: email.value
    })

    success.value = res.data.message || 'Reset token sent to email'
  } catch (e) {
    error.value =
      e.response?.data?.message || 'Email not found'
  }
}
</script>

<style scoped>
.page {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #eef2f3, #dbeafe);
}

.form-container {
  width: 100%;
  max-width: 400px;
  background: #ffffff;
  padding: 30px;
  border-radius: 10px;
  box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
}

.form-container h2 {
  text-align: center;
  margin-bottom: 6px;
  color: #333;
}

.subtitle {
  text-align: center;
  font-size: 14px;
  color: #666;
  margin-bottom: 20px;
}

.form-container input {
  width: 100%;
  padding: 12px;
  margin-bottom: 14px;
  border: 1px solid #ddd;
  border-radius: 6px;
  font-size: 14px;
}

.form-container input:focus {
  outline: none;
  border-color: #2563eb;
}

.form-container button {
  width: 100%;
  padding: 12px;
  background: #2563eb;
  color: #fff;
  border: none;
  border-radius: 6px;
  font-size: 15px;
  cursor: pointer;
}

.form-container button:hover {
  background: #1d4ed8;
}

.success {
  margin-top: 12px;
  color: #16a34a;
  font-size: 14px;
  text-align: center;
}

.error {
  margin-top: 12px;
  color: #dc2626;
  font-size: 14px;
  text-align: center;
}
</style>

