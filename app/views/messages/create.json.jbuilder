json.nickname @message.user.nickname
json.date @message.created_at.strftime("%Y/%m/%d")
json.time @message.created_at.strftime("%H:%M")
json.message @message.message
json.id @message.id