import { ref } from 'vue'

export const isLoggedIn = ref(!!localStorage.getItem('token'))
export const currentUserId = ref(Number(localStorage.getItem('user_id')) || null)
