defmodule Checker do
  use GenServer


  def init(init_arg) do
        {:ok, init_arg}
      end


      def decode_tweet(tweet) do
          decode = Poison.decode!(tweet.data)
          decode["message"]["tweet"]["text"]
          |> String.replace([".", ":", "!", "?", ","], "")
          |> String.split(" ", trim: true)
        end

        def compare_sentiments(val) do
          words_val = Enum.map(val, fn word -> Sentiments.get_sentiment(word) end)
          final_score = Enum.sum(words_val)
          IO.inspect(final_score)
        end

        def print_tweet(tweet) do

          if tweet.data =~ "panic" do
            IO.inspect("Panic message")
            else
            compare_sentiments(decode_tweet(tweet))

          end
        end

end
