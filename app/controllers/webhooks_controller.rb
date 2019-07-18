class WebhooksController < ApplicationController
  def webhooks
    case params['type']
    when 'checkout.session.completed' then ''
    end
    render :json => {:status => 200}
  end
end
