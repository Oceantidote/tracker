class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_period!
  before_action :configure_permitted_parameters, if: :devise_controller?

  include Pundit

  # Pundit: white-list approach.
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def configure_permitted_parameters
    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :position, :last_name, :photo, :company_logo, :company, :source])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :position, :last_name, :photo, :company_logo, :company, :source])
  end

  def set_period!
    @current_period = Period.find_by(user: current_user, end_time: nil)
  end

  def renderActionInOtherController(controller,action,params)
    controller.class_eval{
      def params=(params); @params = params end
      def params; @params end
    }
    c = controller.new
    c.request = @_request
    c.response = @_response
    c.params = params
    c.send(action)
    c.response.body
  end
end
