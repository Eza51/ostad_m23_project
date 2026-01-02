<template>
  <div class="page">
    <div class="form-container">
      <h2>Reset Password</h2>
      <p class="subtitle">
        Enter your reset token and choose a new password
      </p>

      <input v-model="email" type="email" placeholder="Email" />
      <input v-model="token" placeholder="Reset token" />

      <input
        v-model="password"
        type="password"
        placeholder="New Password"
      />
      <input
        v-model="password_confirmation"
        type="password"
        placeholder="Confirm Password"
      />

      <button @click="resetPassword">
        Reset Password
      </button>

      <p class="success" v-if="success">{{ success }}</p>
      <p class="error" v-if="error">{{ error }}</p>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import axios from 'axios'

const route = useRoute()
const router = useRouter()

const email = ref('')
const token = ref('')
const password = ref('')
const password_confirmation = ref('')
const success = ref('')
const error = ref('')

onMounted(() => {
  email.value = route.query.email || ''
  token.value = route.query.token || ''
})

const resetPassword = async () => {
  success.value = ''
  error.value = ''

  try {
    const res = await axios.post('/reset-password', {
      email: email.value,
      token: token.value,
      password: password.value,
      password_confirmation: password_confirmation.value
    })

    success.value = res.data.message

    setTimeout(() => {
      router.push('/login')
    }, 1500)
  } catch (e) {
    error.value = e.response?.data?.message || 'Failed to reset password'
  }
}
</script>

<style scoped>
.page {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #f0f4ff, #e0e7ff);
}

.form-container {
  width: 100%;
  max-width: 420px;
  background: #ffffff;
  padding: 32px;
  border-radius: 12px;
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.12);
}

.form-container h2 {
  text-align: center;
  margin-bottom: 6px;
  color: #1f2937;
}

.subtitle {
  text-align: center;
  font-size: 14px;
  color: #6b7280;
  margin-bottom: 22px;
}

.form-container input {
  width: 100%;
  padding: 12px;
  margin-bottom: 14px;
  border: 1px solid #d1d5db;
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
  color: #fff;
  border: none;
  border-radius: 6px;
  font-size: 15px;
  cursor: pointer;
  transition: background 0.2s ease;
}

.form-container button:hover {
  background: #4338ca;
}

.success {
  margin-top: 14px;
  color: #16a34a;
  font-size: 14px;
  text-align: center;
}

.error {
  margin-top: 14px;
  color: #dc2626;
  font-size: 14px;
  text-align: center;
}
</style>
