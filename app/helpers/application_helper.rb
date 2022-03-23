module ApplicationHelper
  attr_reader :current_organization

  def no_header_footer?
    (params[:controller]   == 'pages' && params[:action] == 'error_404') ||
      (params[:controller] == 'pages' && params[:action] == 'error_422') ||
      (params[:controller] == 'pages' && params[:action] == 'error_500') ||
      (params[:controller] == 'organizations')
  end

  def humanize_time(time)
    time.strftime('%Y-%d-%b %H:%M')
  end

  def humanize_date(date)
    date.strftime('%Y-%d-%I')
  end

  def user_strength
    ['0', '1 - 10', '11 - 20', '21 - 30', '31 - 40', '41 - 50']
  end

  def get_string_initials(string)
    string.split(' ').map { |w| w.chars[0].upcase }.join
  rescue StandardError
    ''
  end
end
