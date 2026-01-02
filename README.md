# Ostad M23 Project — Blog Management System

This is a **full-stack Blog Management System** built using **Laravel REST API** and **Vue 3 (Vite)** as part of the Ostad Module 23 project.

## 🎥 Demo Video
👉 https://youtu.be/NSYXmW9krbM

## 📂 GitHub Repository
👉 https://github.com/Eza51/ostad_m23_project

---

## 🧠 Project Overview

This project allows users to register, log in, and manage blog posts.  
Users can create posts with public/private visibility, comment with nested replies, like posts, and bookmark them.  
Guest users can only view **public posts**.

---

## 🛠️ Tech Stack

- **Backend:** Laravel (REST API)
- **Frontend:** Vue.js 3 + Vite
- **Routing:** Vue Router
- **HTTP Client:** Axios
- **Authentication:** Laravel Sanctum (Token Based)
- **Database:** MySQL

---

## ✨ Features

### 🔐 Authentication
- User registration & login
- Token-based authentication (Sanctum)
- Logout functionality
- Forgot & Reset password using email

### 📝 Post Management
- Create, update & delete posts
- Public & private post visibility
- Latest posts shown first
- Image upload for posts

### 💬 Interaction
- Comment system with nested replies
- Like / Unlike posts
- Bookmark posts
- Tags support for posts

### 🌐 Frontend (Vue 3)
- `v-if`, `v-for`, `v-model`
- Vue Router navigation
- Axios with interceptor
- Component-based architecture
- Optimistic UI updates (like, comment)

---

## 🗂️ Project Structure

ostad_m23_project/
│
├── backend/ # Laravel API
│ ├── app/
│ ├── routes/api.php
│ ├── database/
│ └── ...
│
├── frontend/ # Vue 3 + Vite
│ ├── src/
│ │ ├── views/
│ │ ├── components/
│ │ ├── router/
│ │ └── ...
│
└── ostad_blog.sql # Database SQL file


---

## 🚀 How to Run the Project

### 🔧 Backend Setup (Laravel)

```bash
cd backend
composer install
cp .env.example .env
php artisan key:generate


Update .env file:

DB_DATABASE=ostad_blog
DB_USERNAME=root
DB_PASSWORD=
FRONTEND_URL=http://localhost:5173


Run migrations and server:

php artisan migrate
php artisan serve

🎨 Frontend Setup (Vue 3)
cd frontend
npm install
npm run dev


Frontend URL:

http://localhost:5173

🔗 API Routes (Summary)
Public

POST /api/register

POST /api/login

POST /api/forgot-password

POST /api/reset-password

GET /api/posts/public

Authenticated (Sanctum)

GET /api/posts

POST /api/posts

PUT /api/posts/{id}

DELETE /api/posts/{id}

POST /api/comments

POST /api/like/{postId}

POST /api/bookmark/{postId}

POST /api/logout

📧 Password Reset Email

Mail system uses Laravel password broker.
Mailtrap (or any SMTP) can be configured in .env:

MAIL_MAILER=smtp
MAIL_HOST=sandbox.smtp.mailtrap.io
MAIL_PORT=2525
MAIL_USERNAME=your_username
MAIL_PASSWORD=your_password

✅ Notes

Clean MVC structure

Secure API with Sanctum

Database SQL included

Demo video attached

All project requirements fulfilled

Submitted by:
Nowshin Eza
