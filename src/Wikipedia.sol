// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Wikipedia {
    uint256 public counter;
    struct Article {
        uint256 id;
        address author;
        bytes32 previousVersion;
        uint256 timestamp;
        bytes32 ipfsHash;
        bytes32 imageHash;
        string title;
    }

    constructor() {
        counter = 0;
    }

    mapping(uint256 => Article) public articlesById;

    function addNewArticle(
        bytes32 previousVersion,
        bytes32 ipfsHash,
        bytes32 imageHash,
        string calldata title
    ) public returns (uint256) {
        counter++;
        uint256 id = counter;
        Article memory article = Article(
            id,
            msg.sender,
            previousVersion,
            block.timestamp,
            ipfsHash,
            imageHash,
            title
        );
        articlesById[id] = article;
        return id;
    }

    function getArticleAuthor(uint256 id) public view returns (address) {
        return articlesById[id].author;
    }

    function getArticlePreviousVersion(
        uint256 id
    ) public view returns (bytes32) {
        return articlesById[id].previousVersion;
    }

    function getArticleTimestamp(uint256 id) public view returns (uint256) {
        return articlesById[id].timestamp;
    }

    function getArticleIpfsHash(uint256 id) public view returns (bytes32) {
        return articlesById[id].ipfsHash;
    }

    function getArticleImageHash(uint256 id) public view returns (bytes32) {
        return articlesById[id].imageHash;
    }

    function getArticleTitle(uint256 id) public view returns (string memory) {
        return articlesById[id].title;
    }

    function getLastArticles(uint256 n) public view returns (Article[] memory) {
        Article[] memory articles = new Article[](10);
        for (uint256 i = 0; i < 10; i++) {
            articles[i] = articlesById[counter - i];
        }
        return articles;
    }

    // function editArticle(uint256 id, address author, bytes32 newIpfsHash) public {
    //     Article memory article = Article(id, author, previousVersion, ipfsHash);
    //     articlesByTitle[title] = article;
    // }
}
