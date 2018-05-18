Brakemanのドキュメントの[オプション](https://brakemanscanner.org/docs/options/)の部分だけを翻訳しました。

日本語は第1言語ではないので読みやすさのために編集リクエストをよろしくお願いいたします。

後はそのページ自体がちょっと古いみたいだからコードの書き方もちょっと古いです。

```erb
<%= some_method(option: params[:input]) %> #じゃなくて
<%= some_method(:option => params[:input]) %> #とか
```

まあ、サイトがアップデートされない限りその部分を敢えてそのまま残しておこうと思っています。

よろしくお願いいたします

<hr>

# オプション

このページには最新の情報が載っていないかもしれません。説明は短いですが、最新のオプションの情報を`brakeman --help`で確認できます。

下記のいくつかのオプションは短い方(`-`)と長い方(`--`)の書き方両方は出てきますが、すべてのオプションは長い方の書き方も存在しています。

<hr>

## スキャンする時のオプション
デフォルトとして、いくつかのチェックは実行されません。すべてのチェックを実行するには、次のオプションをお使いください：
`brakeman -A`

デフォルトとして、各チェックは独自のスレッドで実行されます。この振る舞いを解除するには、次のオプションをお使いください：
`brakeman -n`

デフォルトとして、Brakemanは現在のディレクトリをスキャンします。パスを引数として渡すこともできます：
`brakeman some/path/to/app`

もっと明確にするには、`-p`もしくは`--path`を書いてください：
`brakeman -p path/to/app`

情報が含まっている警告を抑制して報告だけを出力には、次のオプションをお使いください：
`brakeman -q`

報告以外の出力は全部stderrに送られるので、stdoutがファイルにリダイレクトされ、報告だけを出力するのは簡単です。

何かの間違いがない限り、Brakemanは0を終了コードとして返します。警告が出る時、エラーコードを返すには、次のオプションをお使いください：
`brakeman -z`

強制にRails 3モードで実行するには、次のオプションをお使いください：
`brakeman -3`

もしくは強制にRails 4モードで：
`brakeman -4`

いくつかの振る舞いとチェックは何バージョンを知らないと使えません。でも、現在のRailsのアプリには`Gemfile.lock`があるので、問題はないでしょう。

Brakemanは前はコントローラのメソッドの中でどれがアクションとして使われているかを推測するために`routes.rb`をパース(parse)していました。しかし、これは完璧なやり方ではないです（得にRails3・4において）ですので、コントローラのすべてのメソッドはアクションとして扱われます。この振る舞いを解除するには、次のオプションをお使いください：
`brakeman --no-assume-routes`

こうする必要はないかもしれませんが、デフォルトとして出力がエスケープされるように強制に定義することができます：
`brakeman --escape-html`

Brakemanの動作が少し重たいなら、次のオプションをお使いください：
`brakeman --faster`

いくつかの機能は省かれますが、こうすることによってもうちょっと速くなるでしょう（これは`--skip-libs --no-branching`と同じです）。*注意：*いくつかの脆弱性は検知されない可能性があります。

`if`文の流れの感知(Flow Sensitivity)を解除するには：
`brakeman --no-branching`

逆に値を渡してブランチの個数を制限するには、次のオプションをお使いください：
`brakeman --branch-limit LIMIT`

`LIMIT`は整数を渡してください。`0`は`--no-branching`とほぼ同じですが、`--no-branching`の方がおススメです。デフォルトの値は`5`です。より低い値はBrakemanの動作を速めます。`-1`は無制限と同じです。

ファイルをとばすには、次のオプションをお使いください：
`brakeman --skip-files file1,file2,etc`

Brakemanは「プログラムの全体」の解析をしますので、定義されたファイルが出す警告以外には、そのファイルをとばしたことによって他のファイルにも影響はあるかもしれません。

上記のオプションの反対ですがより危ないオプションは次のとおりです：
`brakeman --only-files some_file,some_dir`

また、Brakemanはプログラム全体を解析しますので、ファイルの部分集合をスキャンしてしまうと、期待している結果は出ないかもしれなせん。更に、いくつかの必要なファイルがないとBrakemanは動作しません。

ディレクトリの`lib/`の処理を省略するには：
`brakeman --skip-libs`

部分集合のチェックを実行するには：
`brakeman --test Check1,Check2,etc`

チェックを省略するには：
`brakeman --except Check1,Check2,etc`

チェックの`Check`の部分を入れる必要はないです。下記の２行は同じ振る舞いをします：
```
brakeman --test CheckSQL
brakeman --test SQL
```
<hr>
## 出力オプション
デバッグの情報を出力するには：
`brakeman -d`

結果のための出力ファイルを定義するには：
`brakeman -o -output_file`

出力の形式はファイルの拡張子か`-f`オプションで決定されます。現在は`text`, `html`, `tabs`, `json`, `markdown`と`csv`があります。

複数の出力ファイルを定義することもできます：
`brakeman -o output.html -o output.json`

HTMLの報告でCSSのスタイルシートを定義するには：
`brakeman -css-file my_cool_styling`

デフォルトとして、同じコードにおいて一つの警告だけが報告されます。これを解除するには、次のオプションをお使いください：
`brakeman --no-combine-locations`

警告の「危ない」、もしくは「ユーザが入力した」値がハイライトされているのを省くには、次のオプションをお使いください：
`brakeman --no-highlights`

コントローラとルーティングの情報を報告するには：
`brakeman --routes`

尚、アプリのルーティングが知りたいなら次のコマンドを実行してください：
`rake routes`

HTML報告のメッセージの長さを制限するには：
`brakeman --message-limit LIMIT`

デフォルトの値は100です。

テキスト報告のテーブルの幅を制限するには：
`brakeman --table-width LIMIT`

もしこのオプションが定義されていなかったら、Brakemanはターミナルの幅を推測するか、テーブルの幅の制限を80字にします。

Brakemanは`attr_accessible`がない全てのモデルをまとめて一つの警告として報告します。モデル毎に警告を出すのはもっと役に立つでしょう。
`brakeman --separate-models`

たまには大きな報告じゃなくて、概要だけで済む時もあります：
`brakeman --summary`

デフォルトとして報告は相対パスを表示します。代わりに絶対パスを表示するには：
`brakeman --absolute-paths`

HTMLやタブの報告には影響がないです。

GitHubのファイルへのリンクが載っているマークダウンを生成するには、次のオプションをお使いください：
`brakeman --github-repo USER/REPO[/PATH][@REF]`

例えば、
`brakeman --github-repo presidentbeef/inject-some-sql`

過去のスキャンと比較するには、JSON出力のオプションを使ってから次のオプションをお使いください：
`brakeman --compare old_report.json`

これは２つのリストのあるJSONを出力します：直された警告のリストと新しい警告のリスト。

デフォルトとして、Brakemanは`less`を使ってページをターミナルに出力します。直接ターミナルに出力するには、次のオプションをお使いください：
`brakeman --no-pager`

<hr>

## 色んな物を無視する
警告を無視するようにBrakemanの設定を変えることができます。デフォルトとして、`config/brakeman.ignore`内にある設定ファイルを調べます。

特定のファイルを使うには：
`brakeman -i path/to/config.ignore`

このファイルを生成・管理するには：
`brakeman -I`

モデルの属性で出てくるXSSの可能性を無視するには：
`brakeman --ignore-model-output`

`attr_protected`のあるモデルはエラーがレイズされます。これを無視するには：
`brakeman --ignore-protected`

信頼できないデータが含まれている不明のメソッドが危ないとBrakemanは疑います。例えば、下記のコードは引っかかってしまいます（Rails 2）：
`<%= some_method(:option => params[:input]) %>`

信頼できないデータが直接に使われている場合のみ、次のオプションをお使いください：
`brakeman --report-direct`

ただし、このオプションは一貫的にサポートされていません。

特定のメソッドが正しくエスケープされた値を返し、XSSのチェックで警告しなくても良いようするには、次のオプションをお使いください：
`brakeman --safe-methods benign_method_escapes_output,totally_safe_from_xss`

Brakemanは`link_to`で作られたURL内のユーザの入力について警告します。RailsはこのようなURLを安全なものにすること(例)プロトコルはHTTP(S)だけを使うとか)は特にないので、安全なメソッドを無視するには、次のオプションをお使いください。
`brakeman --url-safe-methods ensure_safe_protocol_or_something`

<hr>

## 自信レベル

Brakemanは警告毎に自信レベルをつけます。その警告はどれほど大きな問題なのかを推測します。よって、必ず100%合っていると考えないでください。

自信レベルには３つのレベルがあります：

・High - これはシンプルな警告（真偽の値）かユーザの入力は不安全なやり方で扱われている可能性が高いです。
・Medium - これは大体、変数の扱いが不安全だけど、その変数はユーザの入力とは限らないという場合に表示されます。
・Weak - これは大体、ユーザの入力は不安全なやり方で扱われているかもしれない、という場合に表示されます。

特定の自信レベル以上の警告を出力するには：
`brakeman -w3`

switchである`-w`は1から3の数字を受け取り、1がlow(低い、全ての警告を出力)で、3がhigh(高い、自信の高い警告のみ出力)という意味になります。

-----

## 設定のファイル
BrakemanのオプションはYAMLのファイルで保存できますし、そのファイルから読み込むことも可能です。設定のファイルに書き込むのをもっとシンプルにするには、オプションの`-C`を書くことでその他定義されたオプションを出力します。

デフォルトの設定の配置は`./config/brakeman.yml`, `~/.brakeman/config.yml`,と`/etc/brakeman/config.yml`です。

オプションの`-C`では特定の設定のファイルを定義することができます。

<hr>

## その他
チェックの一覧と短い説明を表示するには：
`brakeman --checks`

任意の（デフォルトでない）チェックを表示するには：
`brakeman --optional-checks`

Brakemanを実行するRakeタスクを生成するには：
`brakeman --rake`

RakeはRailsのアプリ全体を読み込みます。これはBrakemanを使うのに必要ではないし、ライブラリ同士がぶつかる可能性もあるため、おススメではありません。

Brakemanのバージョンを表示するには：
`brakeman --version`

本当のオプションの一覧を表示するには：
`brakeman --help`

