require "spec_helper"

RSpec.describe EmojiTranslate do
  it "has a version number" do
    expect(EmojiTranslate::VERSION).not_to be nil
  end

  it "inserts matching emojis into sentences" do
  	sentence = "the house is on fire and the cat is eating the cake";
  	translated = EmojiTranslate.translate sentence

  	expect(translated).to include("🔥")
  	expect(translated).to include("🐱")
  	expect(translated).to include("🍰")
  end

  it "inserts matching keyword emojis into sentences" do
    sentence = "I ate a donut in USA"
    translated = EmojiTranslate.translate sentence

    expect(translated).to include("🍩")
  end

  it "saves punctuation" do
  	sentence = "Hello, world!"
  	translated = EmojiTranslate.translate sentence

  	expect(translated).to eq("👋, 🌎!")
  end

  it "saves line breaks" do
  	sentence = "So\nhere\nwe\nare\nagain!"
  	translated = EmojiTranslate.translate sentence

  	expect(translated.lines.length).to eq(5)
  end
end
