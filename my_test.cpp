#include "gtest/gtest.h" // GTestのヘッダー
#include "calculator.hpp"  // テストしたい関数のヘッダー

/*
 * TEST(テストスイート名, テストケース名)
 *
 * テストスイート名:   関連するテストのグループ名 (例: 「足し算機能」)
 * テストケース名:   個々のテストの名前 (例: 「プラスの数の計算」)
 */

// テストケース1: プラスの数の足し算
TEST(AddFunctionTest, HandlesPositiveNumbers) {
    // 2 + 3 は 5 になるはず
    EXPECT_EQ(5, add(2, 3));
}

// テストケース2: 0を含む足し算
TEST(AddFunctionTest, HandlesZero) {
    EXPECT_EQ(2, add(2, 0));
    EXPECT_EQ(0, add(0, 0));
}

// テストケース3: マイナスの数の足し算
TEST(AddFunctionTest, HandlesNegativeNumbers) {
    EXPECT_EQ(-5, add(-2, -3));
    EXPECT_EQ(1, add(-2, 3));
}


// GTestを実行するための main() 関数
// (これはお決まりの書き方です)
int main(int argc, char **argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
