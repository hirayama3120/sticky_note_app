require "application_system_test_case"

class WhiteboardsTest < ApplicationSystemTestCase
  test "sticky is able to drag and drop" do
    # fixutreで登録したデータを取得しておきます。
    alice = users(:alice);
    bob = users(:bob);
    task2 = tasks(:task2);

    # divのidを設定します。(idを設定しておくことで、テストが格段に楽になりますね。)
    task2_id = "task-" + task2.id.to_s;
    bob_id = "user-" + bob.id.to_s;
    alice_id = "user-" + alice.id.to_s;

    # white_board/mainを開く。
    visit white_board_main_url;

    # 一応各ユーザのタスク数を確認しておきます。
    assert_equal(1, alice.tasks.count);
    assert_equal(0, bob.tasks.count);

    # task2を表示しているエレメントを取得
    div_task2 = find(id: task2_id);

    # bobのUserBoxを表示しているエレメントを取得
    div_bob = find(id: bob_id);

    # aliceのUserBoxを表示しているエレメントを取得
    div_alice = find(id: alice_id);

    # aliceのタスクは1つ、bobのタスクはなし。
    div_alice.assert_selector("div", class: "Sticky", count: 1);
    div_bob.assert_selector("div", class: "Sticky", count: 0);

    # alice said "Hey bob, I think you want to do my job 'task2'."
    # drag_to(ドラッグ先エレメント)
    div_task2.drag_to(div_bob);

    # タスク所有者が入れ替わったことを確認
    div_alice.assert_selector("div", class: "Sticky", count: 0);
    div_bob.assert_selector("div", class: "Sticky", count: 1);

    # 本当かどうか、スクリーンショットを撮ってもらう。
    take_screenshot();

    # データをリロードしてDBにも反映されたことを確認
    alice.tasks.reload;
    bob.tasks.reload;
    assert_equal(0, alice.tasks.count);
    assert_equal(1, bob.tasks.count);

  end

=begin
  test "style check" do
    # white_board/mainを開く。
    visit white_board_main_url;

    # タイトルはfont-weigt: bold, font-size: 24pxのはず。
    # font-weightをマッチする時はboldでなく、数値(700)でマッチします。
    find("div#WhiteBoardTitle").assert_matches_style("font-weight" => "700", "font-size" => "24px");
    find("div#WhiteBoard").assert_matches_style("display" => "flex", "flex-flow" => "row wrap", "align-content" => "flex-start", "align-items" => "flex-start");

    # ユーザ名部分
    username_divs = all("div", class: "UserName");

    username_divs.each do | username_div |
      username_div.assert_matches_style("font-weight" => "700", "font-size" => "18px");
    end

    # 付箋
    # 色はrgba(赤, 緑, 青, 透過率)で比較するようです。
    stickies = all("div", class: "Sticky");

    stickies.each do | sticky |
      sticky.assert_matches_style("background-color" => "rgba(255, 255, 0, 1)", "width" => "100px", "display" => "grid");
    end

  end
=end  
end
