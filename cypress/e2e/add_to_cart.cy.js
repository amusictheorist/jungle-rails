describe('Home page', () => {
  it('should load the home page', () => {
    cy.visit('/')
    cy.contains('Welcome')
  });

  it("adds an item to the cart and verifies the cart count changes", () => {
    cy.visit('/')

    cy.get('.nav-link')
      .contains('My Cart')
      .then(($cartLink) => {
        const initialCartCount = parseInt($cartLink.text().match(/\d+/)[0]) || 0;

        cy.contains('Scented Blade').parents('article').find('.btn').click({ force: true })

        cy.get('.nav-link')
          .contains('My Cart')
          .should(($updatedCartLink) => {
            const updatedCartCount = parseInt($updatedCartLink.text().match(/\d+/)[0]);
            expect(updatedCartCount).to.equal(initialCartCount + 1);
          });
      });
  });
});
