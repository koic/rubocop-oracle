# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Oracle::OnlineIndex, :config do
  context 'Not migrated' do
    let(:cop_config) { { 'MigratedSchemaVersion' => '202004130150' } }

    it 'registers and corrects an offense when not specifing `options: :online` on `add_index`' do
      expect_offense(<<~RUBY, '202104130150_add_title_index_to_articles')
        add_index :articles, :author
        ^^^^^^^^^ Specify `options: :online` option to `add_index`.
      RUBY
    end

    it 'does not register an offense when specifing `options: :online` on `add_index`' do
      expect_no_offenses(<<~RUBY, '202104130150_add_title_index_to_articles')
        add_index :articles, :author, options: :online
      RUBY
    end
  end

  context 'Migrated' do
    let(:cop_config) { { 'MigratedSchemaVersion' => '202104130150' } }

    it 'does not register an offense when not specifing `options: :online` on `add_index`' do
      expect_no_offenses(<<~RUBY, '202104130150_add_title_index_to_articles')
        add_index :articles, :author
      RUBY
    end

    it 'does not register an offense when specifing `options: :online` on `add_index`' do
      expect_no_offenses(<<~RUBY, '202104130150_add_title_index_to_articles')
        add_index :articles, :author, options: :online
      RUBY
    end
  end
end
