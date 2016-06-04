Remembering Simplified Hanzi -- List of hard copy book errors
=============================================================

Below is a list of errors found in the hard copy books.

Note the first three columns of each table (Frame#, Character, Frame key word) points to the frame where the error occurs.
The remaining columns then detail the actual error.

All the errors reported here have been corrected in the XML database.


Source material
---------------

Remembering Simplified Hanzi Book 1
 * ISBN: `978-0-8248-3323-7`
 * Number line: `14                | 6 5 4`

Remembering Simplified Hanzi Book 2
 * ISBN: `978-0-8248-3655-9`
 * Number line: `17 16 15 14 13 12 | 6 5 4 3 2 1`

Remembering Simplified Hanzi Book 2: Errata in 1st printing, updated 14 March 2002
 * <https://nirc.nanzan-u.ac.jp/en/files/2013/02/RHS-2-errata-for-UHP-2nd-printing.pdf>


Incorrect citation
------------------

There is a convention throughout the books where italic text is used within a frame to cite primitive elements.
This error occurs when a frame cites a primitive element, but uses the wrong key word.

| Frame# | Character | Frame key word    | Incorrect key word | Intended key word
|--------|-----------|-------------------|--------------------|------------------
| 1639   | 哼        | hum               | smooth             | go smoothly
| 1703   | 顷        | 100 Chinese acres | spoon              | diced
| 2753   | 叠        | heap              | mulberry tree      | crotches everywhere
| 2755   | 碰        | bump              | person             | stone
| 2905   | 骡        | mule              | insect             | horse

Another instance of this error occurs when a frame cites a primitive element that does not exist in the Remembering Simplified Hanzi books.

| Frame# | Character | Frame key word | Unknown key word | Comment
|--------|-----------|----------------|------------------|--------
| 1301   | 登        | ascend         | rise up          | The sentence: "Keep the key word distinct from rise up (frame 40)." makes no sense.
| 1982   | 熙        | splendid       | underling        | It seems Frame# 731 (臣 feudal official) is missing the sentence: "When this character is used as a primitive, the meaning becomes underling."
| 2638   | 肝        | liver          | offend           | → dry
| 2640   | 奸        | adultery       | offend           | → dry
| 2641   | 汗        | sweat          | offend           | → dry
| 2642   | 杆        | shaft          | drought          | → dry
| 2644   | 罕        | rarely         | offend           | → dry
| 2725   | 焕        | glowing        | sled dogs        | → Victorian lady
| 2897   | 骄        | arrogant       | mirror image     | → angel

Another instance of this error occurs where a frame is incorrectly described as using a primitive element.

| Frame# | Character | Frame key word | Cites            | Comment
|--------|-----------|----------------|------------------|--------
| 34     | 白        | white          | bird             | the 白 primitive does not exist in the 鸟 bird frame.


Sloppy citation
---------------

This error occurs when a frame cites a primitive element using a key word that do not appear in the index.
These are usually synonyms of the intended key word.

| Frame# | Character | Frame key word | Sloppy key word | Intended key word
|--------|-----------|----------------|-----------------|------------------
| 120    | 罗        | silk gauze     | night           | evening
| 161    | 尘        | dust           | earth           | soil
| 1.136  | 冖        | crown          | roof            | house
| 359    | 式        | style          | craft           | work
| 1097   | 继        | carry on       | hook            | fishhook
| 1228   | 围        | surround       | pent up         | pent in
| 2225   | 塘        | pool           | earth           | soil
| 2230   | 笋        | bamboo shoot   | mop             | overseer or (bent) rake


Frame that describes itself using a sloppy key word
---------------------------------------------------

There is a convention throughout the books where bold text is used within frames to highlight its own key word.
This error occurs where the bold text differs from the actual key word (shown in large print at the top of the frame).

| Frame# | Character | Frame Key word    | Text
|--------|-----------|-------------------|-----
| 1.39   | 勹        | bound up          | chain
| 1.39   | 勹        | bound up          | rope
| 2707   | 趁        | take advantage of | for a


Not-index key words
-------------------

This error occurs where a frame has a primitive key word, and this key word is cited by other frames, but is missing from the index (of both books).

| Frame# | Character | Frame Key word | Not-indexed key word
|--------|-----------|----------------|---------------------
| 15     | 目        | eye            | net
| 195    | 宣        | proclaim       | sunrise, sunset


Incorrect frame number
----------------------

This error occurs where a a frame is cited by its frame number, but the number is wrong.

| Frame# | Character | Frame key word | Cited key word | Incorrect Frame# | Correct Frame#
|--------|-----------|----------------|----------------|------------------|---------------
| 57     | 几        | how many?      | wind           | 1170             | 1168
| 668    | 授        | confer         | bestow         | 1007             | 1005
| 2.93   | 爿        | bunk beds      | slice          | 988              | 986
| 2007   | 稣        | rise again     | Jerusalem      | 2738             | 2806
| 2125   | 蒙        | Mongolia       | L.A            | 286              | 315
| 2125   | 蒙        | Mongolia       | England        | 1278             | 1323
| 2.164  | 鉴－金    | bullfighter    | be about to    | 1012             | 1010
| 2545   | 纯        | unadulterated  | unmixed        | 2399             | 2473
| 2670   | 疾        | rapid          | quick          | 1289             | 1287
| 2758   | 凿        | bore a hole    | south          | 1261             | 1259
| 2796   | 敷        | apply          | stew           | 1533             | 1732
| 3018   | 钧        | 30 catties     | catty          | 856              | 924


Incorrect stroke count
----------------------

The Unihan Database <http://unicode.org/charts/unihan.html> and the Taiwan Ministry of Education website <http://stroke-order.learningweb.moe.edu.tw/> were used to detect stroke count discrepancies.
There are three kinds of errors.

The first kind of error is where the stroke count is clearly wrong.

| Frame# | Character | Frame key word     | RSH count | Unihan count | MoE count
|--------|-----------|--------------------|-----------|--------------|----------
| 1437   | 险        | perilous           | 10        | 9            | -
| 1756   | 烫        | scald              | 16        | 10           | -
| 2890   | 馋        | gluttonous         | 14        | 12           | -
| 2901   | 骚        | disturb            | 2         | 12           | -
| 2905   | 骡        | mule               | 17        | 14           | -
| 2970   | 馅        | filling            | 16        | 11           | -
| 2985   | 玻        | glass (front side) | 14        | 9            | 9
| 3003   | 谭        | Tan                | 19        | 14           | -
| 3007   | 冯        | Feng               | 12        | 5            | -
| 3012   | 甸        | outlying areas     | 17        | 7            | 7
| 3013   | 沧        | dark blue          | 13        | 7            | -
| 3016   | 琼        | fine jade          | 19        | 12           | -
| 3017   | 琳        | gem                | 14        | 12           | 12
| 3018   | 钧        | 30 catties         | 12        | 9            | -

The second kind concerns standardisation.
For some frames, the book gives the stroke count derived from the Taiwan/ROC stroke order, instead of the Mainland/PRC stroke order.

| Frame# | Character | Frame key word     | Book count | Unihan count | MoE count
|--------|-----------|--------------------|------------|--------------|----------
| 1732   | 熬        | stew               | 15         | 14           | 15
| 2087   | 傲        | haughty            | 13         | 12           | 13
| 2251   | 鼎        | old cooking pot    | 13         | 12           | 13
| 3005   | 薛        | Xue                | 17         | 16           | 17
| 3008   | 魏        | Wei                | 18         | 17           | 18
| 3009   | 岳        | Yue                | 9          | 8            | 9
| 3010   | 莉        | jasmine            | 11         | 10           | 11
| 3015   | 娜        | na                 | 10         | 9            | 10

The third kind, appears to be a stylistic difference chosen by the authors.

| Frame# | Character | Frame key word     | Book count | Unihan count | MoE count
|--------|-----------|--------------------|------------|--------------|----------
| 420    | 肺        | lungs              | 9          | 8            | 8
| 1688   | 沛        | copious            | 8          | 7            | 7
| 1910   | 怡        | cheerful           | 9          | 8            | 8
| 2121   | 宫        | palace             | 10         | 9            | -
| 2856   | 帐        | tent               | 8          | 7            | -
| 2855   | 胀        | bloated            | 9          | 8            | -


Editorial errors
----------------

| Frame# | Character | Frame key word        | Error                                       | Correction or comment
|--------|-----------|-----------------------|---------------------------------------------|----------------------
| 307    | 条        | strip                 | unbe-nownst                                 | → unbeknownst
| 455    | 背        | back                  | -                                           | Final sentence is missing full stop.
| 2097   | 俄        | Russia                | -                                           | Sentence is missing full stop.
| 2344   | 陋        | undesirable           | The drawing order following the primitives. | Incomplete sentence.
| 2598   | 秦        | Qin                   | Bonzai                                      | → Bonsai
| 2758   | 凿        | bore a hole           | -                                           | Unexpected closing parenthesis after the Yuan symbol.
| 2874   | 呜        | zoom-zoom             | -                                           | In final sentence, parentheses are not closed.
| 2901   | 骚        | disturb               | Note the drawing order and the extra drop.  | The very first sentence is incorrect; there is no extra drop in this character.
| 2975   | 蝴        | butterfly (front-end) | ... forewings are):                         | → ... forewings) are:
