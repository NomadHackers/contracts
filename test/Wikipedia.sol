// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Wikipedia.sol";

contract WikipediaTest is Test {
    Wikipedia public wikipedia;

    function setUp() public {
        wikipedia = new Wikipedia();
    }

    function test_Add() public {
        uint256 id = wikipedia.addNewArticle(
            bytes32(0),
            bytes32(0),
            bytes32(0),
            "Hello World"
        );
        assertEq(id, 1);
        assertEq(wikipedia.getArticleAuthor(1), address(this));
        assertEq(wikipedia.getArticlePreviousVersion(1), bytes32(0));
        assertEq(wikipedia.getArticleTimestamp(1), block.timestamp);
        assertEq(wikipedia.getArticleIpfsHash(1), bytes32(0));
        assertEq(wikipedia.getArticleTitle(1), "Hello World");
        assertEq(wikipedia.getArticleImageHash(1), bytes32(0));
    }

    function test_AddMultiple() public {
        test_Add();
        vm.roll(6);
        vm.prank(address(123));
        uint256 id = wikipedia.addNewArticle(
            bytes32(0),
            bytes32(0),
            bytes32(0),
            "Test2"
        );
        assertEq(id, 2);
        assertEq(wikipedia.getArticleAuthor(2), address(123));
        assertEq(wikipedia.getArticlePreviousVersion(2), bytes32(0));
        assertEq(wikipedia.getArticleTimestamp(2), block.timestamp);
        assertEq(wikipedia.getArticleIpfsHash(2), bytes32(0));
        assertEq(wikipedia.getArticleTitle(2), "Test2");
        assertEq(wikipedia.getArticleImageHash(2), bytes32(0));
    }
}
