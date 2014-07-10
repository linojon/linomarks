require "uri"

class IncomingController < ApplicationController

  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_filter :verify_authenticity_token, only: [:create]

  def create
    # Take a look at these in your server logs
    # to get a sense of what you're dealing with.
    logger.info "INCOMING PARAMS HERE: #{params}"
    logger.info "keys: #{params.keys}"
    logger.info "stripped-text: #{params['stripped-text']}"

    email = params[:sender] 
    user = User.find_by_email email
    topic = /#(\w*)/.match(params[:subject])[1] # e.g "foo #tag bar"
    # http://stackoverflow.com/questions/3665072/extract-url-from-text
    link  =  URI.extract(params['stripped-text'], /http(s)?/).first


    if user
      ok = user.bookmarks.create topic: topic, link: link
      if ok
        logger.info "Created bookmark: #{topic}: #{link}"
      else
        logger.info "failed to create bookmark: #{topic}: #{link}"
      end
      
    else
      logger.info "unknown user #{email}"
    end

    # Assuming all went well. 
    head 200
  end
end