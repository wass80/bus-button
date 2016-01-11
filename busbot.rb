require "slack"
require "json"
require "serialport"

TOKEN = ENV["TOKEN"]
SIRIAL = ENV["SIRIAL"]
BOT_NAME = "kale"

Slack.configure do |config|
  config.token = TOKEN
end
p Slack.auth_test

client = Slack.realtime

def postTo(text, chan)
  Slack.chat_postMessage text: text, channel: chan, username:BOT_NAME
end

def validMsg(data, ch_id)
  if data["channel"] == ch_id && data["username"] != BOT_NAME
    yield data["user"], data["text"], data
  end
end

client.on :hello do
  puts "Successfully connected!"
end

mych = "C0D595XEG"

queue = []
client.on :message do |data|
  validMsg(data, mych) do |name, text, data|
  end
end

Thread.new do
  SerialPort.new(SIRIAL,9600) do |sp|
    prevSt = 0
    loop do
      sp.each_line.map(&:to_i).each_cons(2) do |(p, n)|
        if p == 1 and n == 0
          puts "off"
        elsif p == 0 and n == 1
          puts "on"
        end
      end
    end
  end
end
client.start
