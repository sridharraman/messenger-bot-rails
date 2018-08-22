module Messenger
  module Bot
    class Transmitter
      def initialize(sender)
        @sender_id = sender
      end

      def reply(data,eng_flag)
        data = init_data.merge({ messaging_type:"RESPONSE", message: data })
        access_token = eng_flag ? Messenger::Bot::Config.access_token : Messenger::Bot::Config.math_access_token
        Messenger::Bot::Request.post("https://graph.facebook.com/v2.6/me/messages?access_token=#{access_token}", data)
      end
      
      def send_update(data,eng_flag)
        data = init_data.merge({ messaging_type:"UPDATE", message: data })
        access_token = eng_flag ? Messenger::Bot::Config.access_token : Messenger::Bot::Config.math_access_token
        Messenger::Bot::Request.post("https://graph.facebook.com/v2.6/me/messages?access_token=#{access_token}", data)
      end
      
      def get_profile(eng_flag,fields=nil)
        fields ||= [:locale, :timezone, :gender, :first_name, :last_name, :profile_pic]
        access_token = eng_flag ? Messenger::Bot::Config.access_token : Messenger::Bot::Config.math_access_token
        Messenger::Bot::Request.get("https://graph.facebook.com/v2.6/#{@sender_id}?fields=#{fields.join(",")}&access_token=#{access_token}")
      end

      def action(sender_action=true)
        data = init_data.merge({ sender_action: sender_action ? "typing_on" : "typing_off" })
        Messenger::Bot::Request.post("https://graph.facebook.com/v2.6/me/messages?access_token=#{Messenger::Bot::Config.access_token}", data)
      end

      private

      def init_data
        {
          recipient: {
            id: @sender_id
          }
        }
      end
    end
  end
end
