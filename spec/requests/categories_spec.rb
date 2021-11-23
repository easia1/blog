describe '1. As a User, I want to create a category that can be used to organize my tasks' do
    it 'GET /new' do
        get new_category_path
        expect(response).to have_http_status(200)
    end

    it 'POST /create' do
        expect {
            post new_category_path, params: { category:{name: 'testing'}}
        }.to change(Category, :count).by(1)
    end
end




























# describe 'POST /create' do
#     it 'creates new category' do
#         expect do
#             post '/categories', params: {category:{name: 'Sample name'}}
#         end.to change(Category, :count).by(1)
#     end
# end
