defprotocol Caesar do
  def encrypt(string, shift)

  def rot13(string)
end

defimpl Caesar, for: [BitString, List] do
  @letter_length 26
  @upper_case_start 65
  @upper_case_end 90
  @lower_case_start 97
  @lower_case_end 122

  defp is_upper_case?(i) do
    i >= @upper_case_start && i <= @upper_case_end
  end

  defp is_lower_case?(i) do
    i >= @lower_case_start && i <= @lower_case_end
  end

  def encrypt(string, shift) do
    string
    |> to_char_list
    |> Enum.map(fn i -> shift_car(i, shift) end)
    |> List.to_string
  end

  defp shift_car(i, shift) do
    cond do
      is_upper_case?(i) ->
        rotate( i - @upper_case_start, shift) + @upper_case_start
      is_lower_case?(i) ->
        rotate( i - @lower_case_start, shift) + @lower_case_start
      true ->
        i
    end
  end

  defp rotate(i, shift) do
    rem(i + shift, @letter_length)
  end

  def rot13(string) do
    encrypt(string, 13)
  end
end
