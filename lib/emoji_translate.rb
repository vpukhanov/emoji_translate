require 'emoji_translate/version'

require 'json'

module EmojiTranslate
  @emojis = nil

  def self.transform_to_array(text)
    text.split ' ' unless text.to_s.empty?
  end

  def self.clean_up_word(word)
    begin_punctuation = ''
    end_punctuation = ''

    while !word.empty? && !(word[0] =~ /\W/).nil?
      begin_punctuation += word[0]
      word = word[1..-1]
    end

    while !word.empty? && !(word[word.length - 1] =~ /\W/).nil?
      end_punctuation = word[word.length - 1] + end_punctuation
      word = word[0..-2]
    end

    [begin_punctuation, word, end_punctuation]
  end

  def self.load_emojis
    if @emojis.nil?
      file_path = File.join(File.dirname(__FILE__), '../assets/emojis.json')
      file = File.read file_path
      @emojis = JSON.parse file
    end
    @emojis
  end

  def self.get_all_possibilities(word)
    possible_singular = nil
    possible_singular = word[0..-2] if word.length > 2 && word.end_with?('s')

    possible_plural = word.length > 1 ? word + 's' : nil

    possible_verbed_simple = nil
    possible_verbed_vowel = nil
    possible_verbed_doubled = nil
    if word.end_with?('ing')
      verb = word.chomp 'ing'

      possible_verbed_simple = verb
      possible_verbed_vowel = verb + 'e'
      possible_verbed_doubled = verb[0..-2]
    end

    [
      word,
      possible_singular, possible_plural,
      possible_verbed_simple, possible_verbed_vowel, possible_verbed_doubled
    ].compact
  end

  def self.find_by_keyword(keyword)
    self.load_emojis

    # First, check if it's a common keyword
    if %w{i you}.include? keyword
      return '😊'
    elsif keyword == 'she'
      return '💁'
    elsif keyword == 'he'
      return '💁‍♂️'
    elsif %w{we they}.include? keyword
      return '👩‍👩‍👦‍👦'
    elsif %w{am is are}.include? keyword
      return '👉'
    elsif keyword == 'and'
      return '➕'
    end

    possibilities = self.get_all_possibilities(keyword)

    # Try to find the matching emoji name
    emoji = @emojis.find do |emoji|
      emoji_name, _ = emoji
      possibilities.include? emoji_name
    end
    return emoji[1]['char'] unless emoji.nil?

    # If no matching name was found, search by keywords
    emoji = @emojis.find do |emoji|
      _, emoji_data = emoji
      !(emoji_data['keywords'] & possibilities).empty?
    end
    return emoji[1]['char'] unless emoji.nil?
  end

  def self.translate_word(word)
    self.load_emojis

    begin_punctuation, word, end_punctuation = self.clean_up_word(word)
    downcased = word.downcase

    return begin_punctuation + end_punctuation if word.empty?

    emoji = self.find_by_keyword downcased
    result = emoji.nil? ? word : emoji

    begin_punctuation + result + end_punctuation
  end

  def self.translate_line(line)
    self.load_emojis

    processed_text = self.transform_to_array line
    emojified = processed_text.map { |word| self.translate_word word }

    emojified.join(' ')
  end

  def self.translate(text)
    self.load_emojis

    lines = text.lines
    emojified = lines.map { |line| self.translate_line line }

    emojified.join("\n")
  end
end
