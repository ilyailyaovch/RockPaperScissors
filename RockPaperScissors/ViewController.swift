import UIKit

class RootViewController: UIViewController {

    var viewModel = ViewModel()
    let navButtonView = UIButton(type: .system)
    let infoStack = UIStackView()
    var selectionsStack = UIStackView()
    var userSelection = UILabel()
    var aiSelection = UILabel()
    var scoreStack = UIStackView()
    var gameRezultLabel = UILabel()
    var scoreLabel = UILabel()
    var attemptsLabel = UILabel()
    var cardsView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupNavBar()
        setupLabel()
        setupSelections()
        setupScores()
        setupCards()
    }

    // MARK: - NavBar
    func setupNavBar() {
        navButtonView.setTitle("Players", for: .normal)
        navButtonView.configuration = .plain()
        navButtonView.addTarget(self, action: #selector(openSavedGames), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: navButtonView)
    }

    // MARK: - Label
    func setupLabel() {
        let t1 = UILabel()
        let t2 = UILabel()
        let t3 = UILabel()
        let t4 = UIImageView()

        t1.text = "Rock"
        t1.textColor = .darkGray
        t2.text = "Paper"
        t2.textColor = .darkGray
        t3.text = "Scissors"
        t3.textColor = .darkGray
        t4.image = .init(systemName: "gamecontroller")

        infoStack.axis = .vertical
        infoStack.alignment = .center
        infoStack.spacing = 5
        infoStack.tintColor = .darkGray
        infoStack.addArrangedSubview(t1)
        infoStack.addArrangedSubview(t2)
        infoStack.addArrangedSubview(t3)
        infoStack.addArrangedSubview(t4)
        view.addSubview(infoStack)

        infoStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            infoStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // MARK: - Selections
    func setupSelections() {
        let youStack = UIStackView()
        let aiStack = UIStackView()
        let separator = UILabel()
        let youLabel = UILabel()
        let aiLabel = UILabel()

        setupSelectionsParameters()

        youStack.axis = .vertical
        youStack.alignment = .center
        youStack.spacing = 5
        youStack.addArrangedSubview(userSelection)
        youStack.addArrangedSubview(youLabel)
        youLabel.text = "You"

        aiStack.axis = .vertical
        aiStack.alignment = .center
        aiStack.spacing = 5
        aiStack.addArrangedSubview(aiSelection)
        aiStack.addArrangedSubview(aiLabel)
        aiLabel.text = "Ai"

        selectionsStack.axis = .horizontal
        selectionsStack.alignment = .center
        selectionsStack.distribution = .equalCentering
        selectionsStack.spacing = 5
        selectionsStack.layer.cornerRadius = 10
        selectionsStack.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        selectionsStack.isLayoutMarginsRelativeArrangement = true
        selectionsStack.addArrangedSubview(youStack)
        selectionsStack.addArrangedSubview(separator)
        selectionsStack.addArrangedSubview(aiStack)
        view.addSubview(selectionsStack)

        userSelection.font = .systemFont(ofSize: 30)
        aiSelection.font = .systemFont(ofSize: 30)
        separator.text = "-"

        selectionsStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            selectionsStack.topAnchor.constraint(equalTo: infoStack.bottomAnchor, constant: 60),
            selectionsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectionsStack.heightAnchor.constraint(equalToConstant: 80),
            selectionsStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            selectionsStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }

    func setupSelectionsParameters(){
        userSelection.text = viewModel.userSelection
        aiSelection.text = viewModel.aiSelection
    }

    // MARK: - Score
    func setupScores() {
        let gameStatStack = UIStackView()

        setupScoresParameteres()

        gameStatStack.axis = .vertical
        gameStatStack.alignment = .center
        gameStatStack.distribution = .fillEqually
        gameStatStack.spacing = 5
        gameStatStack.layer.cornerRadius = 10
        gameStatStack.backgroundColor = .lightGray.withAlphaComponent(0.1)
        gameStatStack.layoutMargins = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        gameStatStack.isLayoutMarginsRelativeArrangement = true
        gameStatStack.addArrangedSubview(scoreLabel)
        gameStatStack.addArrangedSubview(attemptsLabel)

        scoreStack.axis = .vertical
        scoreStack.alignment = .center
        scoreStack.distribution = .equalCentering
        scoreStack.spacing = 10
        scoreStack.layer.cornerRadius = 10
        scoreStack.addArrangedSubview(gameRezultLabel)
        scoreStack.addArrangedSubview(gameStatStack)
        view.addSubview(scoreStack)

        scoreStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scoreStack.topAnchor.constraint(equalTo: selectionsStack.bottomAnchor, constant: 60),
            scoreStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scoreStack.heightAnchor.constraint(equalToConstant: 80),
            scoreStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            scoreStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }

    func setupScoresParameteres(){
        gameRezultLabel.text = viewModel.gameRezult
        gameRezultLabel.textColor = .black
        scoreLabel.text = "Score : \(viewModel.score)"
        attemptsLabel.text = "Attempts : \(viewModel.attempts) / 5"
    }

    // MARK: - Cards
    func setupCards() {

        setupCardsParameteres()

        cardsView.axis = .horizontal
        cardsView.alignment = .center
        cardsView.distribution = .fillEqually
        cardsView.spacing = 10
        view.addSubview(cardsView)

        for i in 0..<5 {
            let card = CardView()
            card.index = i
            card.setTitle("\(viewModel.cards[i].text)", for: .normal)
            card.addTarget(self, action: #selector(squareTapped(_:)), for: .touchUpInside)
            card.isUserInteractionEnabled = true
            cardsView.addArrangedSubview(card)
        }

        cardsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cardsView.topAnchor.constraint(equalTo: scoreStack.bottomAnchor, constant: 80),
            cardsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 50),
            cardsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            cardsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }

    func setupCardsParameteres(){
        viewModel.makeCards()
        for card in cardsView.arrangedSubviews {
            card.removeFromSuperview()
        }
    }

    func cleanUp(){
        self.viewModel.reset()
        self.setupSelectionsParameters()
        self.setupScoresParameteres()
        self.setupCards()
    }

    // MARK: - objc
    @objc func squareTapped(_ sender: CardView) {
        viewModel.playGame(cardIndex: sender.index)
        self.userSelection.text = viewModel.userSelection
        self.aiSelection.text = viewModel.aiSelection
        self.gameRezultLabel.text = viewModel.gameRezult
        switch viewModel.gameRezult {
        case "Tie!":
            self.gameRezultLabel.textColor = .black
            sender.isUserInteractionEnabled = true
        default:
            self.gameRezultLabel.textColor = viewModel.gameRezult == "You win!" ? .green : .red
            sender.alpha = 0.5
            sender.isUserInteractionEnabled = false
        }
        switch viewModel.attempts {
        case 5:
            let title = viewModel.score >= 3 ? "You won!" : "AI won!"
            let message = "Woukd you like to save the game?"
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addTextField()
            alert.textFields![0].placeholder = "Enter your name"
            alert.addAction(UIAlertAction(title: "New game", style: UIAlertAction.Style.default, handler: { _ in
                self.cleanUp()
            }))
            alert.addAction(UIAlertAction(title: "Save", style: UIAlertAction.Style.cancel, handler: { _ in
                self.viewModel.addUser(name: alert.textFields![0].text ?? "", score: self.viewModel.score)
                self.viewModel.saveUsers()
                self.cleanUp()
            }))
            self.present(alert, animated: true, completion: nil)
        default: break
        }
        self.scoreLabel.text = "Score : \(viewModel.score)"
        self.attemptsLabel.text = "Attempts : \(viewModel.attempts) / 5"
    }

    @objc func openSavedGames(){
        let savedGamesScreen = UsersView(delegate: self.viewModel)
        navigationController?.pushViewController(savedGamesScreen, animated: true)
    }

}
