# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Oracle::OnlineIndex, :config do
  context 'Migration file has not been migrated' do
    let(:cop_config) { { 'MigratedSchemaVersion' => '202004130150' } }

    it 'registers and corrects an offense when not specifing `options: :online` on `add_index`' do
      expect_offense(<<~RUBY, 'db/migrate/202104130150_add_title_index_to_articles.rb')
        add_index :articles, :author
        ^^^^^^^^^ Specify `options: :online` option to `add_index`.
      RUBY

      expect_correction(<<~RUBY)
        add_index :articles, :author, options: :online
      RUBY
    end

    it 'does not register an offense when specifing `options: :online` on `add_index`' do
      expect_no_offenses(<<~RUBY, 'db/migrate/202104130150_add_title_index_to_articles.rb')
        add_index :articles, :author, options: :online
      RUBY
    end
  end

  context 'Migration file has been migrated' do
    let(:cop_config) { { 'MigratedSchemaVersion' => '202104130150' } }

    it 'does not register an offense when not specifing `options: :online` on `add_index`' do
      expect_no_offenses(<<~RUBY, 'db/migrate/202104130150_add_title_index_to_articles.rb')
        add_index :articles, :author
      RUBY
    end

    it 'does not register an offense when specifing `options: :online` on `add_index`' do
      expect_no_offenses(<<~RUBY, 'db/migrate/202104130150_add_title_index_to_articles.rb')
        add_index :articles, :author, options: :online
      RUBY
    end
  end

  context '`MigratedSchemaVersion` is not specified' do
    it 'does not register an offense when not specifing `options: :online` on `add_index`' do
      expect_no_offenses(<<~RUBY, 'db/migrate/202104130150_add_title_index_to_articles.rb')
        add_index :articles, :author
      RUBY
    end

    it 'does not register an offense when specifing `options: :online` on `add_index`' do
      expect_no_offenses(<<~RUBY, 'db/migrate/202104130150_add_title_index_to_articles.rb')
        add_index :articles, :author, options: :online
      RUBY
    end
  end
end
