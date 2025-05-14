llm = Langchain::LLM::OpenAI.new(
  api_key: ENV["OPENAI_API_KEY"],
  default_options: { chat_model: "gpt-4.1" }
  #default_options: { temperature: 0.0, chat_model: "gpt-4o-mini" }
  #default_options: { chat_model: "o3-mini" }
)
Rails.application.config.llm = llm
