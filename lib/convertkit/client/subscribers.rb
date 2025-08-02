module Convertkit
  class Client
    module Subscribers
      def subscribers(options = {})
        connection.get("subscribers", options)
      end

      def subscriber(subscriber_id)
        connection.get("subscribers/#{subscriber_id}")
      end

      def subscriber_tags(subscriber_id)
        connection.get("subscribers/#{subscriber_id}/tags")
      end

      # returns an hash with the following keys:
      # {
      #   "subscriber": {
      #     "id": 3436990966,
      #     "stats": {
      #       "sent": 2,
      #       "opened": 2,
      #       "clicked": 2,
      #       "bounced": 0,
      #       "open_rate": 1,
      #       "click_rate": 1,
      #       "last_sent": "2025-06-25 16:44:37.000",
      #       "last_opened": "2025-06-25 16:45:36.000",
      #       "last_clicked": "2025-06-25 16:45:42.000",
      #       "sent_since_last_open": 0,
      #       "sent_since_last_click": 0
      #     }
      #   }
      # }
      def subscriber_stats(subscriber_id)
        connection.get("subscribers/#{subscriber_id}/stats")
      end

      def update_subscriber(subscriber_id, options = {})
        response = connection.put("subscribers/#{subscriber_id}") do |f|
          f.params["email_address"] = options[:email_address] if options[:email_address]
          f.params["fields"] = options[:fields] if options[:fields]
          f.params["first_name"] = options[:first_name] if options[:first_name]
        end
        response.body
      end

      def unsubscribe(email)
        connection.put("unsubscribe") do |f|
          f.params['email'] = email
        end
      end

      def remove_tag_from_subscriber(subscriber_id, tag_id)
        connection.delete("subscribers/#{subscriber_id}/tags/#{tag_id}")
      end
    end
  end
end
