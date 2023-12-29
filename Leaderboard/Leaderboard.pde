import java.util.Comparator;

/** Leaderboard
  * A simple interface for the leaderboard of an arcade game.
  * Data is stored in data/scores.csv with the header "name,score"
  * Each entry is a name of 3 letters and an integer high score.
  * Only the top 5 scores are stored in the file.
  * To add an entry, enter text and press Enter.
  * To save the file, exit the program.
  */

Table scores;
TextBox nameBox, scoreBox;

void setup() {
  size(600, 600);
  
  // Don't include the header as a row in the table
  scores = loadTable("scores.csv", "header");
  
  // Set the proper datatype for each score
  scores.setColumnType("score", Table.INT);
  
  sortScores();
  
  nameBox = new TextBox(100, 410);
  scoreBox = new TextBox(100, 525);
}

void draw() {
  background(50);
  
  textSize(50);
  noStroke();
  fill(255, 255, 255);
  
  textAlign(CENTER);
  text("TOP 5 SCORES:", width/2, 50);
  text("INITIALS", width/2 - 100, 100);
  text("SCORE", width/2 + 100, 100);
  
  fill(255, 255, 0);
  for (int i = 0; i < scores.getRowCount(); i++) {
    TableRow row = scores.getRow(i);
    String name = row.getString("name");
    int score = row.getInt("score");
    
    int y = 150 + (50 * i);
    text(name, width/2 - 100, y);
    text(score, width/2 + 100, y);
  }
  
  fill(0, 255, 255);
  text("ENTER PLAYER NAME:", width/2, 400);
  text("ENTER SCORE:", width/2, 515);
  
  nameBox.display();
  scoreBox.display();
}

/** Add a new high score to the database using input from the user */
void addScore() {
  String name = nameBox.content;
  int score = int(scoreBox.content);
  
  updateScore(name, score);
  sortScores();
  
  // Only keep the top 5 scores
  if (scores.getRowCount() > 5)
    scores.removeRow(5);
}

/** Update an existing entry, or add a new one if none exists */
void updateScore(String name, int score) {
  for (TableRow row : scores.rows()) {
    if ( row.getString("name").equals(name) ) {
      if ( score > row.getInt("score") )
        row.setInt("score", score);
      return;
    }
  }
  
  Object[] columns = {name, score};
  scores.addRow(columns);
}

/** Sort the leaderboard and replace existing records */
void sortScores() {
  ArrayList<Entry> entries = new ArrayList<>();
  
  for (TableRow tr : scores.rows()) {
    Entry entry = new Entry(tr.getString("name"), tr.getInt("score"));
    entries.add(entry);
  }
  
  // Sort entries first by score (descending) then by player name (ascending)
  // this avoids "randomizing" scores that have the same number
  entries.sort(
    Comparator.comparing((Entry e) -> e.score).reversed()
      .thenComparing((Entry e) -> e.name)
  );
  
  // Replace existing table rows in the correct order
  scores.clearRows();
  
  for (int i = 0; i < entries.size(); i++) {
    Entry entry = entries.get(i);
    Object[] columns = {entry.name, entry.score};
    scores.addRow(columns);
  }
}

void mouseClicked() {
  nameBox.listenMouse();
  scoreBox.listenMouse();
}

void keyPressed() {
  nameBox.listenKey();
  scoreBox.listenKey();
  
  if (keyCode == ENTER)
    addScore();
}

/** Determines if the user has pressed a letter or number.
  * Used for entering text in textboxes. */
boolean isValidKey() {
  String k = String.valueOf(key);
  return k.matches("[a-zA-z0-9]");
}

void exit() {
  saveTable(scores, "data/scores.csv");
  stop();
}
