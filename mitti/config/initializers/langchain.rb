llm = Langchain::LLM::OpenAI.new(
  api_key: ENV["OPENAI_API_KEY"],
  default_options: { temperature: 0.7, chat_model: "gpt-4.1" }
)
Rails.application.config.llm = llm
