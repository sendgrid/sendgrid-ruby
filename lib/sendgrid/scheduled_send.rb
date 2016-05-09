require 'faraday'

module SendGrid
  class ScheduledSend
    class << self
      def client=(client)
        fail client_not_found_exception unless client.is_a?(SendGrid::Client)
        fail basic_auth_exception if client.api_user.nil? || client.api_key.nil?
        client.conn.basic_auth(client.api_user, client.api_key)
        @client = client
      end
      
      def client
        fail client_not_found_exception unless @client.is_a?(SendGrid::Client)
        @client
      end
      
      def generate_batch_id
        client.post(url: "/v3/mail/batch").body["batch_id"]
      end
      
      def validate_batch_id(batch_id)
        client.get(url: "/v3/mail/batch/#{batch_id}").body["batch_id"]
      end
      
      def scheduled_sends
        client.get(url: "/v3/user/scheduled_sends").body
      end
      
      def cancel_scheduled_send(batch_id)
        client.post(url: "/v3/user/scheduled_sends", 
                    payload: {
                      batch_id: batch_id,
                      status: "cancel"
                    })
      end
      
      def pause_scheduled_send(batch_id)
        client.post(url: "/v3/user/scheduled_sends",
                    payload: { 
                      batch_id: batch_id, 
                      status: "pause"
                    })
      end
      
      def update_scheduled_send(batch_id, status)
        client.patch(url: "/v3/user/scheduled_sends/#{batch_id}",
                     payload: { status: status })
      end
      
    private
    
      def client_not_found_exception
        @_client_not_found_exception ||= SendGrid::Exception.new("SendGrid::Client not found. Please set SendGrid::ScheduledSend.client to an instance of SendGrid::Client")
      end
      
      def basic_auth_exception
        @_basic_aith_exception ||= SendGrid::Exception.new("You must authorize the client with your username and password. API tokens are not supported at this time.")
      end
    end
  end
end