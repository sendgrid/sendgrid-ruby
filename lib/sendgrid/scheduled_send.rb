require 'faraday'

module SendGrid
  class ScheduledSend
    class << self
      def client
        SendGrid::Client.client
      end
      
      def generate_batch_id
        client.post(url: "/v3/mail/batch").body["batch_id"]
      end
      
      def validate_batch_id(batch_id)
        client.get(url: "/v3/mail/batch/#{batch_id}").body["batch_id"]
      end
      
      def scheduled_send(batch_id)
        client.get(url: "/v3/user/scheduled_sends/#{batch_id}").body
      end
      
      def scheduled_sends
        client.get(url: "/v3/user/scheduled_sends").body
      end
      
      def cancel_scheduled_send(batch_id)
        if scheduled_send(batch_id).empty?
          client.post(url: "/v3/user/scheduled_sends", 
                      payload: {
                        batch_id: batch_id,
                        status: "cancel"
                      })
        else
          update_scheduled_send(batch_id, "cancel")
        end
      end
      
      def pause_scheduled_send(batch_id)
        if scheduled_send(batch_id).empty?
          client.post(url: "/v3/user/scheduled_sends",
                      payload: { 
                        batch_id: batch_id, 
                        status: "pause"
                      })
        else
          update_scheduled_send(batch_id, "pause")
        end
      end
      
      def update_scheduled_send(batch_id, status)
        client.patch(url: "/v3/user/scheduled_sends/#{batch_id}",
                     payload: { status: status })
      end
    end
  end
end