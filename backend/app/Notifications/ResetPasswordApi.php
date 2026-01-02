<?php

namespace App\Notifications;

use Illuminate\Notifications\Notification;
use Illuminate\Notifications\Messages\MailMessage;

class ResetPasswordApi extends Notification
{
    public $token;

    public function __construct($token)
    {
        $this->token = $token;
    }

    public function via($notifiable)
    {
        return ['mail'];
    }

    public function toMail($notifiable)
    {
        $resetUrl =
            config('app.frontend_url') .
            '/reset-password?token=' . $this->token .
            '&email=' . urlencode($notifiable->email);

        return (new MailMessage)
            ->subject('Reset Password')
            ->line('You requested a password reset.')
            ->action('Reset Password', $resetUrl)
            ->line('----------------------------')
            ->line('OR copy this token manually:')
            ->line($this->token)
            ->line('----------------------------')
            ->line('If you did not request this, ignore this email.');
    }
}
