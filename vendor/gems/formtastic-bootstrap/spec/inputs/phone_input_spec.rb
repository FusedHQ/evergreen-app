# encoding: utf-8
require 'spec_helper'

describe 'phone input' do

  include FormtasticSpecHelper

  before do
    @output_buffer = ''
    mock_everything
  end

  describe "when object is provided" do
    before do
      concat(semantic_form_for(@new_post) do |builder|
        concat(builder.input(:phone))
      end)
    end

    it_should_have_bootstrap_horizontal_wrapping
    it_should_have_input_wrapper_with_class(:phone)
    it_should_have_input_wrapper_with_class(:input)
    it_should_have_input_wrapper_with_class(:stringish)
    it_should_have_input_wrapper_with_id("post_phone_input")
    it_should_have_label_with_text(/Phone/)
    it_should_have_label_for("post_phone")
    it_should_have_input_with_id("post_phone")
    it_should_have_input_with_type(:tel)
    it_should_have_input_with_name("post[phone]")

  end

  describe "when namespace is provided" do

    before do
      concat(semantic_form_for(@new_post, :namespace => "context2") do |builder|
        concat(builder.input(:phone))
      end)
    end

    it_should_have_input_wrapper_with_id("context2_post_phone_input")
    it_should_have_label_and_input_with_id("context2_post_phone")

  end
  
  describe "when index is provided" do

    before do
      @output_buffer = ''
      mock_everything

      concat(semantic_form_for(@new_post) do |builder|
        concat(builder.fields_for(:author, :index => 3) do |author|
          concat(author.input(:name, :as => :phone))
        end)
      end)
    end
    
    it 'should index the id of the control group' do
      output_buffer.should have_tag("div.control-group#post_author_attributes_3_name_input")
    end
    
    it 'should index the id of the select tag' do
      output_buffer.should have_tag("input#post_author_attributes_3_name")
    end
    
    it 'should index the name of the select tag' do
      output_buffer.should have_tag("input[@name='post[author_attributes][3][name]']")
    end
    
  end
  
  
  describe "when required" do
    it "should add the required attribute to the input's html options" do
      with_config :use_required_attribute, true do 
        concat(semantic_form_for(@new_post) do |builder|
          concat(builder.input(:title, :as => :phone, :required => true))
        end)
        output_buffer.should have_tag("input[@required]")
      end
    end
  end
  
end

