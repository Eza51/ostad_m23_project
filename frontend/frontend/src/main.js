import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import axios from 'axios'

// Set base URL for Axios
axios.defaults.baseURL = 'http://127.0.0.1:8000/api'

// Attach token if exists
axios.interceptors.request.use(config => {
  const token = localStorage.getItem('token')
  if (token) {
    config.headers.Authorization = `Bearer ${token}`
  }
  return config
})

createApp(App)
  .use(router)
  .mount('#app')
