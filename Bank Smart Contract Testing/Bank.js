const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("UserBank Contract", function () {

  let UserBank;
  let userBank;
  let owner;
  let user1;

  beforeEach(async function () {
  UserBank = await ethers.getContractFactory("UserBank");
  [owner, user1] = await ethers.getSigners();

  userBank = await UserBank.deploy();
  await userBank.waitForDeployment();
  });

  // 1️⃣ Deployment test
  it("Should deploy successfully with zero balance", async function () {
    const balance = await userBank.Get_Balance();
    expect(balance).to.equal(0);
  });

  // 2️⃣ Deposit test
  it("Should deposit amount and update total balance", async function () {
    await userBank.deposit(1000);

    const balance = await userBank.Get_Balance();
    expect(balance).to.equal(1000);
  });

  // 3️⃣ Deposit event test
  it("Should emit Depo event on deposit", async function () {
    await expect(userBank.deposit(500))
      .to.emit(userBank, "Depo")
      .withArgs(owner.address, 500);
  });

  // 4️⃣ Deposit from different user
  it("Should allow multiple users to deposit", async function () {
    await userBank.deposit(1000);
    await userBank.connect(user1).deposit(2000);

    const balance = await userBank.Get_Balance();
    expect(balance).to.equal(3000);
  });

  // 5️⃣ Deposit revert test
  it("Should revert if deposit amount is zero", async function () {
    await expect(userBank.deposit(0))
      .to.be.revertedWith("Add Some Money");
  });

  // 6️⃣ Withdraw test
  it("Should withdraw amount correctly", async function () {
    await userBank.deposit(2000);
    await userBank.withdraw_cash(500);

    const balance = await userBank.Get_Balance();
    expect(balance).to.equal(1500);
  });

  // 7️⃣ Withdraw revert test (insufficient funds)
  it("Should revert if withdraw amount is greater than balance", async function () {
    await userBank.deposit(1000);

    await expect(userBank.withdraw_cash(1500))
      .to.be.revertedWith("Insufficient fund");
  });

  // 8️⃣ Full withdrawal test
  it("Should allow withdrawing full balance", async function () {
    await userBank.deposit(1000);
    await userBank.withdraw_cash(1000);

    const balance = await userBank.Get_Balance();
    expect(balance).to.equal(0);
  });

});
