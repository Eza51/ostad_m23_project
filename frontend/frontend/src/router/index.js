import { createRouter, createWebHistory } from 'vue-router'
import Login from '../views/Login.vue'
import Register from '../views/Register.vue'
import Posts from '../views/Posts.vue'
import Profile from '../views/Profile.vue'
import ForgetPassword from '../views/ForgetPassword.vue'
import ResetPassword from '../views/ResetPassword.vue'

const routes = [
  { path: '/', component: Posts },
  { path: '/login', component: Login },
  { path: '/register', component: Register },
  { path: '/profile', component: Profile },
  { path: '/forget-password', component: ForgetPassword },
  { path: '/reset-password', component: ResetPassword },
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router


