require 'rest-client'
require 'json'
require 'base64'
require 'io/console'
class ForumRestClient

  #@@DOMAIN = 'https://csa-web-service-cloftus.c9users.io'
  @@DOMAIN = 'http://localhost:3000'

  @user = nil
  @password = nil

  def run_menu
    loop do
      display_menu
      option = STDIN.gets.chomp.upcase
      case option
        when '1'
          puts 'Logging in:'
          login
        when '2'
          puts 'Logging out:'
          logout
        when '3'
          puts 'Displaying threads:'
          display_topics
        when '4'
          puts 'Displaying thread:'
          display_topic
        when '5'
          puts 'Creating thread:'
          create_topic
        when 'Q'
          break
        else
          puts "Option #{option} is unknown."
      end
    end
  end

  private

  def display_menu
    puts
    puts
    puts 'Enter option: '
    puts '1. Login'
    puts '2. Logout'
    puts '3. Display all threads'
    puts '4. Display a thread by ID'
    puts '5. Create a new thread'
    puts 'Q. Quit'
  end

  def login
    if (@user.nil? || @password.nil?)
      print "Login: "
      login = STDIN.gets.chomp
      print "Password: "
      password = STDIN.noecho(&:gets).chomp
      if (login.nil? || password.nil?)
        puts "The login or password provided was incorrect"
      else
        puts "Logged in"
        @user = login
        @password = password
      end
    else
      puts "You're already logged in!"
    end
  end

  def logout
    if (@user.nil? || @password.nil?)
      puts "You're not logged in!"
    else
      @user = nil
      @password = nil
      puts "Logged out"
    end
  end

  def display_topics
    if (@user.nil? || @password.nil?)
      puts "You need to login first"
    else
      begin
        response = RestClient.get "#{@@DOMAIN}/api/topics.json?all=true", authorization_hash

        puts "Response code: #{response.code}"
        puts "Response cookies:\n #{response.cookies}\n\n"
        puts "Response headers:\n #{response.headers}\n\n"
        puts "Response content:\n #{response.to_str}"

        js = JSON response.body
        js.each do |item_hash|
          item_hash.each do |k, v|
            puts "#{k}: #{v}"
          end
        end
      rescue => e
        puts STDERR, "Error accessing REST service. Error: #{e}"
      end
    end
  end

  def display_topic
    if (@user.nil? || @password.nil?)
      puts "You need to login first"
    else
      begin
        print "Enter the thread ID: "
        id = STDIN.gets.chomp
        response = RestClient.get "#{@@DOMAIN}/api/topics/#{id}.json", authorization_hash

        js = JSON response.body
        js.each do |k, v|
          puts "#{k}: #{v}"
        end
      rescue => e
        puts STDERR, "Error accessing REST service. Error: #{e}"
      end
    end
  end

  def create_topic
    if (@user.nil? || @password.nil?)
      puts "You need to login first"
    else
      begin
        print "Title: "
        title = STDIN.gets.chomp
        print "Body: "
        body = STDIN.gets.chomp
        print "Post as anonymous? (y/n): "
        anonymous = STDIN.gets.chomp.upcase == 'Y'

        params = {
          post: {
            title: title,
            body: body
          }
        }
        if anonymous
          params[:anonymous] = "true"
        end
        response = RestClient.post "#{@@DOMAIN}/api/topics.json", params, authorization_hash

        if (response.code == 201)
          puts "Created successfully"
        end
        puts "URL for new resource: #{response.headers[:location]}"
      rescue => e
        puts STDERR, "Error accessing REST service. Error: #{e}"
      end
    end
  end

  def authorization_hash
    {Authorization: "Basic #{Base64.strict_encode64(@user + ':' + @password)}"}
  end
end

client = CSARestClient.new
client.run_menu
