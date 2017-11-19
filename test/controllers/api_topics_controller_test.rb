require 'test_helper'

class ApiTopicsControllerTest < ActionDispatch::IntegrationTest

  test "should get access denied" do
    get '/api/topics'
    assert_response :unauthorized
  end

  test "should get all threads" do
    get '/api/topics?all=true', headers: {'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials("cwl2","secret") }
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal(2, json.size)
  end

  test "should display one thread by id" do
    topic_id = topics(:one).id
    get '/api/topics/' + topic_id.to_s, headers: {'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials("cwl2","secret") }
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal(topics(:one).title, json['title'])
  end

  test "should create a new thread" do
    post '/api/topics', params: {post: {title: "Hello there", body: "coffee is life"}},
      headers: {'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials("cwl2","secret") }
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal("Hello there", json['title'])
    get '/api/topics?all=true', headers: {'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials("cwl2","secret") }
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal(3, json.size)
  end

  test "should create a new anonymous thread" do
    post '/api/topics', params: {post: {title: "Hello there", body: "coffee is life"}, anonymous: "true"},
      headers: {'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials("cwl2","secret") }
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal("Hello there", json['title'])
    assert_nil(json['author'])
    get '/api/topics?all=true', headers: {'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials("cwl2","secret") }
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal(3, json.size)
  end
end
