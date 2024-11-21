describe ('Home page', () => {
  it('should load the home page', () => {
    cy.visit('/')
    cy.contains('Welcome')
  });

  it("There are 2 products on the page", () => {
    cy.visit("/");
    cy.get(".products article").should("have.length", 2);
  });
});