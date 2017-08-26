require "emoji_translate/version"

require "json"

module EmojiTranslate
  @@emojis = nil

  def self.transform_to_array(text)
  	#text.scan /[\w'-]+|[[:punct]]+/ unless text.to_s.empty?
  	text.split " " unless text.to_s.empty?
  end

  def self.load_emojis
  	if @@emojis.nil?
  		file_path = File.join(File.dirname(__FILE__), "../assets/emojis.json")
  		file = File.read file_path
  		@@emojis = JSON.parse file
  	end
  	@@emojis
  end

  def self.find_by_keyword(keyword)
  	self.load_emojis

  	possible_singular = (keyword[-1] == 's') ? keyword[0..-2] : keyword
  	possible_plural = (keyword.length > 1) ? keyword + "s" : keyword

  	# Try to find the matching emoji name
  	emoji = @@emojis.find do |emoji|
  		emoji_name, emoji_data = emoji
  		emoji_name == keyword || 
  		emoji_name == possible_singular || 
  		emoji_name == possible_plural
  	end
  	return emoji[1]["char"] unless emoji.nil?

  	# If no matching name was found, search by keywords
  	emoji = @@emojis.find do |emoji|
  		emoji_name, emoji_data = emoji
  		emoji_data["keywords"].include?(keyword) ||
  		emoji_data["keywords"].include?(possible_singular) ||
  		emoji_data["keywords"].include?(possible_plural)
  	end
  	return emoji[1]["char"] unless emoji.nil?
  end

  def self.translate_word(word)
  	self.load_emojis

  	# This is horrible 😢

  	begin_punctuation = ""
  	end_punctuation = ""

  	while (word.length > 0 && !(word[0] =~ /\W/).nil?)
  		begin_punctuation += word[0]
  		word = word[1..-1]
  	end

  	while (word.length > 0 && !(word[word.length - 1] =~ /\W/).nil?)
  		end_punctuation = word[word.length - 1] + end_punctuation
  		word = word[0..-2]
  	end

	emoji = self.find_by_keyword word.downcase
	result = emoji.nil? ? word : emoji

	begin_punctuation + result + end_punctuation
  end

  def self.translate(text)
  	self.load_emojis

  	processed_text = self.transform_to_array text
  	emojified = processed_text.map { |word| self.translate_word word }
 
  	emojified.join(" ")
  end
end
