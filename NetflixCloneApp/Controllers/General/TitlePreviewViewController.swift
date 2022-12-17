//
//  TitlePreviewViewController.swift
//  NetflixCloneApp
//
//  Created by Rıdvan Yılmaz on 15.11.2022.
//

import UIKit
import WebKit

class TitlePreviewViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let overviewLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private let watchLaterButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Watch Later", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        return button
    }()
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
        
    }()
    
    private var posterPath: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(watchLaterButton)
        
        watchLaterButton.addTarget(self, action: #selector(didTapWatchLaterButton), for: .touchUpInside)
            
        configureConstraints()

    }
    
    @objc private func didTapWatchLaterButton() {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}

        let context = appDelegate.persistentContainer.viewContext
        
        let item = TitleItem(context: context)

        item.title = titleLabel.text
        item.poster_path = posterPath

            do {
                try context.save()
                NotificationCenter.default.post(name: NSNotification.Name("Added"), object: nil)
                print("downloaded database")
            } catch { }
    }
    
    func configureConstraints() {
        let webViewConstraints = [
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 300)
            ]
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ]
        let overviewlabelConstraints = [
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            overviewLabel.heightAnchor.constraint(equalToConstant: 250)
        ]
        let downloadButtonConstraints = [
            watchLaterButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 20),
            watchLaterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            watchLaterButton.widthAnchor.constraint(equalToConstant: 140),
            watchLaterButton.heightAnchor.constraint(equalToConstant: 40),
        ]
        
        NSLayoutConstraint.activate(webViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(overviewlabelConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
    }
    
    func configure(with model: TitlePreviewViewModel) {
        titleLabel.text = model.title
        overviewLabel.text = model.titleOverview
        posterPath = model.posterPath
        
        guard let url = URL(string: "https://youtube.com/embed/\(model.youtubeView.id.videoId)") else {return}
        
        webView.load(URLRequest(url: url))
    }
    
    
 

}
