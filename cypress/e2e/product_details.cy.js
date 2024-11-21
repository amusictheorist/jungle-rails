describe ('Home page', () => {
  it('should load the home page', () => {
    cy.visit('/')
    cy.contains('Welcome')
  });
  
  it("clicks the product 'Scented Blade'", () => {
    cy.visit('/')
    cy.contains('Scented Blade').click()
  });
});