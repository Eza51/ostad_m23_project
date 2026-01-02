<template>
  <div id="app">
    <header class="header">
      <h1> Blog System</h1>
      <nav>
        <ul>
          <li v-if="!isLoggedIn"><router-link to="/login">Login</router-link></li>
          <li v-if="!isLoggedIn"><router-link to="/register">Register</router-link></li>
          <li v-if="isLoggedIn"><button @click="logout">Logout</button></li>
        </ul>
      </nav>
    </header>

    <main>
      <router-view />
    </main>
     <!-- Footer -->
    <footer class="footer">
      <p>Developed by Nowshin Jerin Eza</p>
    </footer>
  </div>
</template>

<script setup>
import { useRouter } from 'vue-router'
import { isLoggedIn } from './store/auth'

const router = useRouter()

const logout = () => {
  localStorage.removeItem('token')
  localStorage.removeItem('user_id')
  isLoggedIn.value = false
  router.push('/login')
}
</script>

<style>
body {
  font-family: Arial, sans-serif;
  margin: 0;
  padding: 0;
}
.header {
  background-color: #7da8b4;
  color: #fff;
  padding: 15px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.header h1 {
  margin: 0;
}
.header nav ul {
  list-style: none;
  display: flex;
  gap: 15px;
  margin: 0;
  padding: 0;
}
.header nav ul li {
}
.header nav ul li a, .header nav ul li button {
  color: #fff;
  text-decoration: none;
  background: none;
  border: none;
  cursor: pointer;
  font-size: 16px;
}
main {
  padding: 20px;
}
/* Footer style */
.footer {
  background-color: #7da8b4;
  color: #fff;
  text-align: center;
  padding: 12px 0;
}
</style>

