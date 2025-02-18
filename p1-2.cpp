// Este codigo solo encuentre la primer solucion (no necesariamente la mejor)
#include<bits/stdc++.h>
using namespace std;
using namespace chrono;

vector<pair<int, int>> moves = {
  {-2, -2}, {-2, 2}, {2, -2}, {2, 2},
};
int n;

bool check(unsigned long long board, int i, int j) {
  int a, b;

  for (auto [x, y] : moves) {
    a = i + x;
    b = j + y;

    if (a >= 0 && a < n && b >= 0 && b < n && (board & (1LL << (a * n + b)))) {
      return false;
    }
  }

  return true;
}

void dfs(unsigned long long board, int i, int j, int knights) {
  if (i == n) {
    cout << '\n' << knights << '\n';

    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        cout << ((board & (1LL << (i * n + j))) ? 1 : 0) << ' ';
      }
      cout << '\n';
    }

    exit(0);
  }

  int x = (j + 1 < n) ? i : i + 1;
  int y = (j + 1 < n) ? j + 1 : 0;

  if (check(board, i, j)) {
    board |= (1LL << (i * n + j));
    dfs(board, x, y, knights + 1);
  } else dfs(board, x, y, knights);
}

int main() {
  cout << "n = ";
  cin >> n;

  dfs(0LL, 0, 0, 0);
}
