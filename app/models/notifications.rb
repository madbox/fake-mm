# -*- coding: utf-8 -*-
class Notifications < ActionMailer::Base
  def signup(user, password, sent_at = Time.now)
    subject    'Fake-mm: регистрация'
    recipients user.email
    from       'noreply@fake-mm.ru'
    sent_on    sent_at
    
    body       :email => user.email, :password => password
  end

  def recover_password( user, password, sent_at = Time.now )
    subject    'Fake-mm: восстановление пароля'
    recipients user.email
    from       'noreply@fake-mm.ru'
    sent_on    sent_at
    
    body       :email => user.email, :password => password
  end
end
