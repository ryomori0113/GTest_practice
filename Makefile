CXX		= c++
NAME	= run_tests

# GTestの場所
GTEST_DIR		= ./googletest/googletest
# ヘッダーパス (共通)
INCLUDES		= -I. -I$(GTEST_DIR)/include

# --- フラグの定義 ---

# 1. あなたのプロジェクト用 (C++98 厳格)
PROJ_CXXFLAGS	= -std=c++98 -Wall -Wextra -Werror -g

# 2. あなたのテストコード用 (C++11 準拠)
TEST_CXXFLAGS	= -std=c++11 -Wall -Wextra -g

# 3. GTestライブラリ用 (C++11, 警告緩め)
GTEST_CXXFLAGS	= -std=c++11 -g -pthread

# リンク用フラグ
LDFLAGS		= -pthread

# --- ソースファイルの定義 ---

# 1. プロジェクトのソース (C++98でコンパイルするもの)
PROJ_SRCS		= calculator.cpp
PROJ_OBJS		= $(PROJ_SRCS:.cpp=.o)

# 2. テストコードのソース (C++11でコンパイルするもの)
TEST_SRCS		= my_test.cpp
TEST_OBJS		= $(TEST_SRCS:.cpp=.o)

# 3. GTestライブラリのソース (C++11でコンパイルするもの)
GTEST_SRC		= $(GTEST_DIR)/src/gtest-all.cc
GTEST_OBJ		= $(GTEST_SRC:.cc=.o)

# --- ビルドルール ---

all: $(NAME)

# リンク (全オブジェクトファイルを集める)
$(NAME): $(PROJ_OBJS) $(TEST_OBJS) $(GTEST_OBJ)
	$(CXX) -o $(NAME) $(PROJ_OBJS) $(TEST_OBJS) $(GTEST_OBJ) $(LDFLAGS)

# --- コンパイルルール (3種類に分離) ---

# 1. プロジェクトの .cpp をコンパイル (C++98 ルール)
$(PROJ_OBJS): %.o: %.cpp
	$(CXX) $(PROJ_CXXFLAGS) $(INCLUDES) -c $< -o $@

# 2. テストコードの .cpp をコンパイル (C++11 ルール)
$(TEST_OBJS): %.o: %.cpp
	$(CXX) $(TEST_CXXFLAGS) $(INCLUDES) -c $< -o $@

# 3. GTestライブラリの .cpp をコンパイル (C++11 緩いルール)
$(GTEST_OBJ): $(GTEST_SRC)
	$(CXX) $(GTEST_CXXFLAGS) $(INCLUDES) -I$(GTEST_DIR) -c $< -o $@

# --- クリーンルール ---

clean:
	rm -f $(PROJ_OBJS) $(TEST_OBJS) $(GTEST_OBJ)

fclean: clean
	rm -f $(NAME)

re: fclean all

test: all
	@./$(NAME)

.PHONY: all clean fclean re test