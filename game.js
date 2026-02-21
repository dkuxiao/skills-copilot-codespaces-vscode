let targetNumber = generateTarget();
let attempts = 0;

const guessInput = document.getElementById('guessInput');
const guessBtn = document.getElementById('guessBtn');
const resetBtn = document.getElementById('resetBtn');
const messageEl = document.getElementById('message');
const attemptsEl = document.getElementById('attempts');

guessBtn.addEventListener('click', handleGuess);
resetBtn.addEventListener('click', resetGame);
guessInput.addEventListener('keydown', function (e) {
  if (e.key === 'Enter') {
    e.preventDefault();
    handleGuess();
  }
});

function generateTarget() {
  return Math.floor(Math.random() * 100) + 1;
}

function handleGuess() {
  const guess = parseInt(guessInput.value, 10);

  if (isNaN(guess) || guess < 1 || guess > 100) {
    messageEl.className = '';
    messageEl.textContent = '1〜100の数字を入力してください。';
    return;
  }

  attempts++;
  attemptsEl.textContent = `試行回数: ${attempts} 回`;

  if (guess === targetNumber) {
    messageEl.className = 'success';
    messageEl.textContent = `🎉 正解！ ${attempts} 回で当たりました！`;
    guessBtn.disabled = true;
    guessInput.disabled = true;
    resetBtn.classList.remove('hidden');
  } else if (guess > targetNumber) {
    messageEl.className = 'hint-high';
    messageEl.textContent = '📉 もっと小さい数字です。';
  } else {
    messageEl.className = 'hint-low';
    messageEl.textContent = '📈 もっと大きい数字です。';
  }

  guessInput.value = '';
  guessInput.focus();
}

function resetGame() {
  targetNumber = generateTarget();
  attempts = 0;
  guessInput.value = '';
  guessInput.disabled = false;
  guessBtn.disabled = false;
  messageEl.textContent = '';
  messageEl.className = '';
  attemptsEl.textContent = '';
  resetBtn.classList.add('hidden');
  guessInput.focus();
}
